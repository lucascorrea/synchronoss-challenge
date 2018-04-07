//
//  Global.swift
//  vrex
//
//  Created by Lucas Correa on 15/12/15.
//  Copyright © 2015 SiriusCode. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Global {
    internal static var dateFormatter: DateFormatter = DateFormatter()
}

//
// MARK: - Function

func delay(_ delay: Double, closure: @escaping () -> Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
    closure()
  }
    
}
