//
//  StationSpec.swift
//  SynchronossTests
//
//  Created by Lucas Correa on 08/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import synchronoss

class StationSpec: QuickSpec {
    
    override func spec() {
        
        beforeEach {
            
        }
    
        describe("Station") {
            it ("should create a new Station") {
                let station = Station(stationId: 0,
                                      name: "Rathdrum",
                                      alias: "",
                                      latitude: 52.9295,
                                      longitude: -6.22641,
                                      code: "RDRUM",
                                      distance: "1km")
                expect(station).toNot(beNil())
            }
        }
    }
}
