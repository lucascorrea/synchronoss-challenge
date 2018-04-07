//
//  Station.swift
//  synchronoss
//
//  Created by Lucas Correa on 05/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import SWXMLHash

struct Station: XMLIndexerDeserializable {
    
    let stationId: Int
    let name: String
    let alias: String
    let latitude: Double
    let longitude: Double
    let code: String
    let distance: String
    
    static func deserialize(_ node: XMLIndexer) throws -> Station {
        return try Station(
            stationId: node["StationId"].value(),
            name: node["StationDesc"].value(),
            alias: node["StationAlias"].value(),
            latitude: node["StationLatitude"].value(),
            longitude: node["StationLongitude"].value(),
            code: node["StationCode"].value(),
            distance: ""
        )
    }
}
