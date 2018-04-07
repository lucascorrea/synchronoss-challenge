//
//  Tweet.swift
//  synchronoss
//
//  Created by Lucas Correa on 07/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation

struct User : Codable {
    
    let screenName: String
    
    private enum CodingKeys : String, CodingKey {
        case screenName = "screen_name"
    }
}

struct Tweet: Codable {
    
    let time: String
    let user : User
    let text: String
    
    private enum CodingKeys: String, CodingKey {
        case time = "created_at"
        case user
        case text
    }
}
