//
//  StationsViewModelSpec.swift
//  SynchronossTests
//
//  Created by Lucas Correa on 08/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import synchronoss

class StationsViewModelSpec: QuickSpec {
    
    override func spec() {
        
        let stationsViewModel: StationsViewModel = StationsViewModel()
        
        beforeEach {
            
        }
        
        describe("StationsViewModel") {
            describe("get list of stations") {
                it("should return a list of stations") {
                    waitUntil(timeout: 60) { done in
                        stationsViewModel.list(success: { (suc) in
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
