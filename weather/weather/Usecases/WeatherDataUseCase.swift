//
//  WeatherDataUseCase.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation

protocol WeatherDataUseCase {
    func getWeatherIcon(weather: WeatherResponse) -> String
    func getTemperature(temp: Double) -> String
    func getConditions(weather: WeatherResponse) -> String
    func getWindSpeed(windSpeed: Double) -> String
    func getHumidity(humidity: Int) -> String
    func getRainChances(dewPoint: Double) -> String
}
