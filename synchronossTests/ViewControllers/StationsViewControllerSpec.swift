//
//  StationsViewControllerSpec.swift
//  SynchronossTests
//
//  Created by Lucas Correa on 08/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import synchronoss

class StationsViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var viewController: StationsViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Main",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "StationsViewController") as? StationsViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
        }
        
        describe("StationsViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    expect(window.rootViewController).toEventually(beAnInstanceOf(StationsViewController.self))
                }
            }
        }
    }
}
