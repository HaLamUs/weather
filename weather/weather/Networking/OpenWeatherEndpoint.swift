//
//  OpenWeatherEndpoint.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import Foundation

enum OpenWeatherEndpoint {
    static let baseUrl = "https://api.openweathermap.org/data/2.5/"
    static func getUrlFor(lat: Double, lon: Double) -> String {
        return "\(baseUrl)onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(token)&units=metric"
    }
}

extension OpenWeatherEndpoint {
    private static var token: String {
        let filePath = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let parameters = NSDictionary(contentsOfFile: filePath)
        return parameters!["OWMAccessToken"]! as! String
    }
}
