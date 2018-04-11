//
//  StationsViewController.swift
//  synchronoss
//
//  Created by Lucas Correa on 05/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import UIKit
import CoreLocation

class StationsViewController: UIViewController, CLLocationManagerDelegate {
    
    //
    // MARK: - Properties
    let stationsViewModel = StationsViewModel()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var stationsTableView: UITableView!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.view.tag != 999 {
            Loading.show(view: UIApplication.shared.keyWindow!)
        }
        
        self.view.tag = 999
        stationsViewModel.list(success: { _ in
            Loading.close(view: UIApplication.shared.keyWindow!)
            self.stationsTableView.reloadData()
        }, failure: { (_, _, _) in
            let alert = UIAlertController(title: "Error", message: "Error request list of Stations.", preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            Loading.close(view: UIApplication.shared.keyWindow!)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //
    // MARK: - UIStoryboardSegueDelegate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showStationDetail" {
            let destination: StationDetailViewController = (segue.destination as? StationDetailViewController)!
            destination.stationDetailViewModel.station = sender as? Station
        }
    }
    
    //
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        stationsViewModel.userLocation = manager.location!
        self.stationsTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension StationsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationsViewModel.stationsItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StationCell = (tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath) as? StationCell)!
        stationsViewModel.configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension StationsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        Loading.show(view: UIApplication.shared.keyWindow!)
        
        let stationData = self.stationsViewModel.stationsItems[indexPath.row]
        self.performSegue(withIdentifier: "showStationDetail", sender: stationData)
    }
}
