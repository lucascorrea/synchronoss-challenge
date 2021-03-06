//
//  StationDetailViewModelSpec.swift
//  SynchronossTests
//
//  Created by Lucas Correa on 08/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import synchronoss

class StationDetailViewModelSpec: QuickSpec {
    
    override func spec() {
    
        let stationDetailViewModel: StationDetailViewModel = StationDetailViewModel()
        
        beforeEach {
        
        }
        
        describe("StationDetailViewModel") {
            describe("get list of stationDatas by Code") {
                it("should return a list of stationDatas") {
                    waitUntil(timeout: 60) { done in
                        stationDetailViewModel.stationDataByCode(code: "MHIDE", success: { (suc) in
                            expect(suc).toNot(beNil())
                            done()
                        },failure: { (_, _, _) in
                        })
                    }
                }
            }
        }
    }
}
