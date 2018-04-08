//
//  NewsViewModelSpec.swift
//  SynchronossTests
//
//  Created by Lucas Correa on 08/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import synchronoss

class NewsViewModelSpec: QuickSpec {
    
    override func spec() {
        
        var newsViewModel: NewsViewModel!
        
        beforeEach {
            newsViewModel = NewsViewModel()
        }
        
        describe("NewsViewModel") {
            describe("get list the tweets of IrishRail") {
                xit("should return a list of tweets") {
                    waitUntil(timeout: 60) { done in
                        newsViewModel.list(success: { (suc) in
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
