//
//  API.swift
//  synchronoss
//
//  Created by Lucas Correa on 05/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation

enum API {
    case allStations
    case stationDataByCode(code: String)
}

extension API {
    var baseURL: URL {
        return URL(string: "http://api.irishrail.ie/realtime/realtime.asmx/")!
    }
    var method: String {
        switch self {
        case .allStations:
            return "GET"
        case .stationDataByCode:
            return "GET"
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
    var headers: [String: String] {
        return [:]
    }
    var parameters: [String: Any] {
        switch self {
        default :
            return [:]
        }
    }
    var url: URL {
        switch self {
        case .allStations:
            return URL(string: "\(baseURL)\(path)")!
        case .stationDataByCode:
            return URL(string: "\(baseURL)\(path)")!
        }
    }
}
