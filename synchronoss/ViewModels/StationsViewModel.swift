//
//  StationsViewModels.swift
//  synchronoss
//
//  Created by Lucas Correa on 05/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import UIKit
import SWXMLHash
import CoreLocation

class StationsViewModel {
    
    //
    // MARK: - Properties
    var stationsItems: [Station]
    var userLocation: CLLocation
    
    //
    // MARK: - Initializer
    init() {
        stationsItems = [Station]()
        userLocation = CLLocation()
    }
    
    //
    // MARK: - Public Functions
    func list(success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        let request = API.allStations
        Network.request(target: request, success: { (response) in
            
            let xml = SWXMLHash.parse(response as? String ?? "")
            self.stationsItems.removeAll()
            
            do {
                self.stationsItems = try xml["ArrayOfObjStation"]["objStation"].value()
                
                // I only kept the 3 stations for testing, but the ideal would be to show everyone and sort by the nearest user.
                let array = self.stationsItems
                self.stationsItems.removeAll()
                array.forEach({ (station) in
                    if station.name == "Dalkey" || station.name == "Rathdrum" || station.name == "Dublin Pearse" {
                        self.stationsItems.append(station)
                    }
                })
                
            } catch {
                print("Error parse of XML")
            }
            
            success(self.stationsItems as AnyObject)
        }, failure: { (response, object, error) in
            failure(response, object, error)
        })
        
    }
    
    // Configure Cell
    func configureCell(cell: inout StationCell, indexPath: IndexPath) {
        let station = stationsItems[indexPath.row]
        cell.nameLabel.text = station.name
        
        let stationLocation = CLLocation(latitude: station.latitude, longitude: station.longitude)
        let distanceInMeters = stationLocation.distance(from: userLocation)
        
        cell.distanceLabel.text = convertDistanceToString(distance: distanceInMeters)
    }
    
    //
    // MARK: - Private Functions
    fileprivate func convertDistanceToString(distance: Double) -> String {
        if (distance < 100) {
            return "\(round(distance)) m"
        } else if (distance < 1000) {
            return "\(round(distance/5)*5) m"
        } else if (distance < 10000) {
            return "\(round(distance/100)/10) km"
        } else {
            return "\(round(distance/1000)) km"
        }
    }
}
