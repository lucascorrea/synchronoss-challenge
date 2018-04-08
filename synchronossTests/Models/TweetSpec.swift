//
//  TweetSpec.swift
//  SynchronossTests
//
//  Created by Lucas Correa on 08/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import synchronoss

class TweetSpec: QuickSpec {
    
    override func spec() {
        var user: User!
        
        beforeEach {
            user = User(screenName: "IrishRail")
        }
        
        describe("Tweet") {
            it ("should create a new Tweet") {
                let tweet = Tweet(time: "Thu Apr 06 15:28:43 +0000 2017", user: user, text: "Test tweet")
                expect(tweet).toNot(beNil())
            }
        }
    }
}
