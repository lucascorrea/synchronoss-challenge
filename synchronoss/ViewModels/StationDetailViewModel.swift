//
//  StationDetailViewModel.swift
//  synchronoss
//
//  Created by Lucas Correa on 06/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import SWXMLHash
import UserNotifications

class StationDetailViewModel {
    
    //
    // MARK: - Properties
    var stationDataItems: [StationData]
    var station: Station?
    
    //
    // MARK: - Initializer
    init() {
        stationDataItems = [StationData]()
    }
    
    //
    // MARK: - Public Functions
    func stationDataByCode(code: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        let request = API.stationDataByCode(code: code)
        Network.request(target: request, success: { (response) in
            
            let xml = SWXMLHash.parse(response as? String ?? "")
            self.stationDataItems.removeAll()
            
            for elem in xml["ArrayOfObjStationData"]["objStationData"].all {
                
                let stationData = StationData(trainCode: elem["Traincode"].element?.text,
                                              queryTime: elem["Querytime"].element?.text,
                                              origin: elem["Origin"].element?.text,
                                              destination: elem["Destination"].element?.text,
                                              status: elem["Status"].element?.text,
                                              schreduleDeparture: elem["Schdepart"].element?.text == "00:00" ? elem["Scharrival"].element?.text : elem["Schdepart"].element?.text,
                                              trainType: elem["Traintype"].element?.text)
                self.stationDataItems.append(stationData)
            }
            
            success(self.stationDataItems as AnyObject)
        }, failure: { (response, object, error) in
            failure(response, object, error)
        })
    }
    
    // Configure Cell
    func configureCell(cell: inout StationDataCell, indexPath: IndexPath) {
        let stationData = stationDataItems[indexPath.row]
        
        cell.stationData = stationData
        cell.trainTypeLabel.text = stationData.trainType
        cell.destinationLabel.text = stationData.destination
        
        if stationData.queryTime != nil &&  stationData.schreduleDeparture != nil {
            let dateFormatter = Global.dateFormatter
            dateFormatter.dateFormat = "HH:mm:ss"
            let dateQueryTime = dateFormatter.date(from:stationData.queryTime!)
            
            dateFormatter.dateFormat = "HH:mm"
            let dateDeparture = dateFormatter.date(from:stationData.schreduleDeparture!)
            
            let difference = Calendar.current.dateComponents([.hour, .minute], from: dateQueryTime!, to: dateDeparture!)
            let formattedString = "\(difference.hour!*60 + difference.minute!)"
            
            cell.minLabel.text = formattedString
        } else {
            cell.minLabel.text = "-"
        }
        
        let alarm = "min before arrival"
        switch stationData.alarm! {
        case 0:
            cell.alarmLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.alarmLabel.text = "Tap to set alarm"
        case 5, 10 ,15, 20, 30:
            cell.alarmLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            cell.alarmLabel.text = "\(stationData.alarm!) \(alarm)"
        
        default:
            cell.alarmLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.alarmLabel.text = "Tap to set alarm"
        }
    }
    
    // Add a alarm to a stationData
    func addAlarm(inMinutes: TimeInterval, identifier: String, stationData: StationData, completion: @escaping (_ Success: Bool) -> Void) {
        // I am adding a alarm to remember the user that the train arrive in X minutes.
        
        //Create Date
        let dateFormatter = Global.dateFormatter
        dateFormatter.dateFormat = "HH:mm"
        let dateQueryTime = dateFormatter.date(from:stationData.schreduleDeparture!)
        
        //Remove minutes based on date above
        let calendar = Calendar(identifier: .gregorian)
        let newDate = calendar.date(byAdding:.minute, value: -Int(inMinutes), to: dateQueryTime!)
        let components = calendar.dateComponents(in: .current, from: newDate!)
        
        //Assign hours and minutes to perform alarm
        var dateComponents = DateComponents()
        dateComponents.hour = components.hour
        dateComponents.minute = components.minute
        
        //Trigger of notification
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //Content
        let content = UNMutableNotificationContent()
        content.title = "Time to go!"
        content.subtitle = ""
        content.body = "Your \(stationData.trainType!.localizedCapitalized) is arriving in \(Int(inMinutes)) minutes!"
        content.sound = UNNotificationSound.default()
        
        //Request of notification
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    // Remove the alarm to a identifier
    func removeAlarm(identifier: String) {
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
            var identifiers: [String] = []
            
            for notification in notificationRequests where notification.identifier == identifier {
                identifiers.append(notification.identifier)
            }
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
        }
    }
}
