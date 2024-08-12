//
//  WeatherDataUseCaseImpl.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation

class WeatherDataUseCaseImpl: WeatherDataUseCase {
    func getWeatherIcon(weather: WeatherResponse) -> String {
        weather.current.weather.first?.icon ?? "dayClearSky"
    }

    func getTemperature(temp: Double) -> String {
        String(format: "%0.1f", temp)
    }

    func getConditions(weather: WeatherResponse) -> String {
        weather.current.weather.first?.main ?? ""
    }

    func getWindSpeed(windSpeed: Double) -> String {
        String(format: "%0.1f", windSpeed)
    }

    func getHumidity(humidity: Int) -> String {
        String(format: "%d%%", humidity)
    }

    func getRainChances(dewPoint: Double) -> String {
        String(format: "%0.1f%%", dewPoint)
    }
}
