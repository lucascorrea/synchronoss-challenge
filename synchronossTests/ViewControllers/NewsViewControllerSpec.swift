//
//  NewsViewControllerSpec.swift
//  SynchronossTests
//
//  Created by Lucas Correa on 08/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import synchronoss

class NewsViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var viewController: NewsViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Main",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as? NewsViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
        }
        
        describe("NewsViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    expect(window.rootViewController).toEventually(beAnInstanceOf(NewsViewController.self))
                }
                
                xit ("should return a list tweets") {
                    waitUntil(timeout: 60) { done in
                        
                        viewController.loadNews(success: { (suc) in
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
