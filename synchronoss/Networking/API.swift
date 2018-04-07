//
//  API.swift
//  synchronoss
//
//  Created by Lucas Correa on 05/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import Alamofire

enum API {
    case allStations
    case stationDataByCode(code: String)
//    http://api.irishrail.ie/realtime/realtime.asmx/getStationDataByCodeXML?StationCode=mhide
}

extension API {
    var baseURL: NSURL {
        return NSURL(string: "http://api.irishrail.ie/realtime/realtime.asmx/")!
    }
    var method: HTTPMethod {
        switch self {
        case .allStations:
            return .get
        case .stationDataByCode:
            return .get
        }
    }
    var path: String {
        switch self {
        case .allStations:
            return "getAllStationsXML"
        case .stationDataByCode(let code):
            return "getStationDataByCodeXML?StationCode=\(code)"
        }
    }
    var headers: [String: String]? {
        return nil
    }
    var parameters: [String: Any]? {
        switch self {
        default :
            return nil
        }
    }
    var url: String {
        switch self {
        case .allStations:
            return "\(baseURL)\(path)"
        case .stationDataByCode:
            return "\(baseURL)\(path)"
        }
    }
}
