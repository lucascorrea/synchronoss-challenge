//
//  Network.swift
//  synchronoss
//
//  Created by Lucas Correa on 05/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import UIKit
import Alamofire

public typealias SuccessHandler = (AnyObject?) -> Void
public typealias FailureHandler = (HTTPURLResponse?, AnyObject?, Error?) -> Void

class Network {
    static func request(target: API, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        print(target.url)
        
        Alamofire.request(target.url, method: target.method, parameters: target.parameters, encoding: URLEncoding.default, headers: target.headers).responseString { (response) in
            
            if response.result.isFailure {
                failure(response.response, response.result.value as AnyObject?, response.result.error)
            } else {
                if let json = response.result.value {
                    success(json as AnyObject)
                }
                
            }
        }
    }
}
