//
//  StationDetailViewControllerSpec.swift
//  SynchronossTests
//
//  Created by Lucas Correa on 08/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import synchronoss

class StationDetailViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var viewController: StationDetailViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        var station: Station!
        
        beforeEach {
            
            station = Station(stationId: 112,
                                  name: "Malahide",
                                  alias: "",
                                  latitude: 53.4509,
                                  longitude: -6.15649,
                                  code: "MHIDE",
                                  distance: "1km")
            
            let storyboard = UIStoryboard(name: "Main",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "StationDetailViewController") as? StationDetailViewController
            
            viewController.stationDetailViewModel.station = station
            window.makeKeyAndVisible()
            window.rootViewController = viewController
        }
        
        describe("StationDetailViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    expect(window.rootViewController).toEventually(beAnInstanceOf(StationDetailViewController.self))
                }
            }
        }
    }
    
}
