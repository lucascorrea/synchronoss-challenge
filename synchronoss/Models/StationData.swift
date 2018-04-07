//
//  StationData.swift
//  synchronoss
//
//  Created by Lucas Correa on 06/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import SWXMLHash

class StationData {
    
    var trainCode: String?
    var queryTime: String?
    var origin: String?
    var destination: String?
    var status: String?
    var schreduleDeparture: String?
    var direction: String?
    var trainType: String?
    var alarm: Int?
    
    init() {
        self.trainCode = ""
        self.queryTime = ""
        self.origin = ""
        self.destination = ""
        self.status = ""
        self.schreduleDeparture = ""
        self.direction = ""
        self.trainType = ""
        self.alarm = 0
    }
    
    init(trainCode: String?, queryTime: String?, origin: String?, destination: String?, status: String?, schreduleDeparture: String?, trainType: String?) {
        self.trainCode = trainCode
        self.queryTime = queryTime
        self.origin = origin
        self.destination = destination
        self.status = status
        self.schreduleDeparture = schreduleDeparture
        self.direction = ""
        self.trainType = trainType
        self.alarm = 0
    }
    
}
