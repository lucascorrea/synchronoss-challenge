//
//  StationDataSpec.swift
//  SynchronossTests
//
//  Created by Lucas Correa on 07/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import synchronoss

class StationDataSpec: QuickSpec {
    
    override func spec() {
        
        beforeEach {
            
        }
        
        describe("StationData") {
            it("should create a new Station") {
                let stationData = StationData()
                expect(stationData).toNot(beNil())
            }
            
            it("should create a new Station with Constructors") {
                let stationData = StationData(trainCode: "E914",
                                              queryTime: "12:34:19",
                                              origin: "Bray",
                                              destination: "Howth",
                                              status: "En Route",
                                              schreduleDeparture: "12:36",
                                              trainType: "DART")
                expect(stationData).toNot(beNil())
            }
        }
        
        afterEach {
            
        }
    }
}
