//
//  StationDetailViewController.swift
//  synchronoss
//
//  Created by Lucas Correa on 06/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import UIKit
import UserNotifications

class StationDetailViewController: UIViewController, StationDataCellDelegate {
    
    //
    // MARK: - Properties
    let stationDetailViewModel = StationDetailViewModel()
    var selectedCellIndexPath: IndexPath?
    var updateCellNotification :NotificationCenter?
    
    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var stationDataTableView: UITableView!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I am not storing the alarms because the activity is to demonstrate the functionality that I find useful for the user, as the test has little time I preferred not to perform this storage functionality if the user exits and re-enters the screen.
        // Another thing that could be done is an automatic request to update the minutes for the shipment if the user stays in this screen
        if stationDetailViewModel.station != nil {
            
            stationLabel.text = stationDetailViewModel.station!.name
            self.navigationItem.title = stationDetailViewModel.station!.name
            
            stationDetailViewModel.stationDataByCode(code: stationDetailViewModel.station!.code, success: { _ in
                
                if self.stationDetailViewModel.stationDataItems.isEmpty {
                    self.stationDataTableView.isHidden = true
                }
                
                Loading.close(view: UIApplication.shared.keyWindow!)
                self.stationDataTableView.reloadData()
            }, failure: { (_, _, _) in
                let alert = UIAlertController(title: "Error", message: "Error request StationData.", preferredStyle: .alert)
                alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                Loading.close(view: UIApplication.shared.keyWindow!)
            })
        }
        
        // Receive the notification that it needs to update on tableview
        updateCellNotification = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "UpdateCell"), object: nil, queue: OperationQueue.main) { (note) in
            
            let notification = note.object as? UNNotification
            
            for stationData in self.stationDetailViewModel.stationDataItems where stationData.trainCode == notification?.request.identifier {
                stationData.alarm = 0
                self.stationDataTableView.reloadData()
            }
            } as? NotificationCenter
    }
    
    deinit {
        NotificationCenter.default.removeObserver(updateCellNotification!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // MARK: - StationDataCellDelegate
    func chanceAlarmToCell(_ cell: StationDataCell, minutes: Int) {
        
        let stationData = stationDetailViewModel.stationDataItems[(selectedCellIndexPath?.row)!]
        
        selectedCellIndexPath = nil
        
        stationDataTableView.beginUpdates()
        stationDataTableView.endUpdates()
        
        stationData.alarm = minutes
        
        let alarm = "min before arrival"
        
        switch minutes {
        case 0:
            cell.alarmLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.alarmLabel.text = "Tap to set alarm"
            
            stationDetailViewModel.removeAlarm(identifier: (stationData.trainCode)!)
        case 5, 10, 15, 20, 30:
            cell.alarmLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            cell.alarmLabel.text = "\(minutes) \(alarm)"
            
            stationDetailViewModel.addAlarm(inMinutes: TimeInterval(minutes), identifier: (stationData.trainCode)!, stationData: stationData) { (success) in
                if success {
                    print("Added alarm")
                } else {
                    print("Error adding alarm")
                }
            }
        default:
            cell.alarmLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.alarmLabel.text = "Tap to set alarm"
        }
    }
}

// MARK: - UITableViewDataSource
extension StationDetailViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationDetailViewModel.stationDataItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: StationDataCell = (tableView.dequeueReusableCell(withIdentifier: "StationDataCell", for: indexPath) as? StationDataCell)!
        
        cell.delegate = self
        stationDetailViewModel.configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension StationDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if selectedCellIndexPath != nil
            && selectedCellIndexPath?.compare(indexPath) == .orderedSame {
            return 177
        }
        
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if selectedCellIndexPath != nil
            && selectedCellIndexPath?.compare(indexPath) == .orderedSame {
            selectedCellIndexPath = nil
        } else {
            selectedCellIndexPath = indexPath
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
