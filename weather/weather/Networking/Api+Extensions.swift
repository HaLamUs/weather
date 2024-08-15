//
//  ApiExtensions.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import Foundation

extension Api {
    static let baseUrl = "https://api.openweathermap.org/data/2.5/"
    
    static func getUrlFor(lat: Double, lon: Double) -> String {
        return "\(baseUrl)onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(key)&units=metric"
    }
}
