//
//  WeatherDataUseCaseImpl.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation

struct WeatherDataUseCaseImpl: WeatherDataUseCase {
    
    func getWeatherAnimation(weather: WeatherResponse) -> String {
        getLottieAnimationFor(
            icon: weather.current.weather.first?.icon ?? "dayClearSky"
        )
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
    
    func getWeatherIconFor(icon: String) -> String {
        switch icon {
        case "01d":
            return "sun.max.fill"
        case "01n":
            return "moon.fill"
        case "02d":
            return "cloud.sun.fill"
        case "02n":
            return "cloud.moon.fill"
        case "03d":
            return "cloud.fill"
        case "03n":
            return "cloud.fill"
        case "04d":
            return "cloud.fill"
        case "04n":
            return "cloud.fill"
        case "09d":
            return "cloud.drizzle.fill"
        case "09n":
            return "cloud.drizzle.fill"
        case "10d":
            return "cloud.heavyrain.fill"
        case "10n":
            return "cloud.heavyrain.fill"
        case "11d":
            return "cloud.bolt.fill"
        case "11n":
            return "cloud.bolt.fill"
        case "13d":
            return "cloud.snow.fill"
        case "13n":
            return "cloud.snow.fill"
        case "50d":
            return "cloud.fog.fill"
        case "50n":
            return "cloud.fog.fill"
        default:
            return "sun.max.fill"
        }
    }
}

extension WeatherDataUseCaseImpl {
    private func getLottieAnimationFor(icon: String) -> String {
        switch icon {
        case "01d":
            return "dayClearSky"
        case "01n":
            return "nightClearSky"
        case "02d":
            return "dayFewClouds"
        case "02n":
            return "nightFewClouds"
        case "03d":
            return "dayScatteredClouds"
        case "03n":
            return "nightScatteredClouds"
        case "04d":
            return "dayBrokenClouds"
        case "04n":
            return "nightBrokenClouds"
        case "09d":
            return "dayShowerRains"
        case "09n":
            return "nightShowerRains"
        case "10d":
            return "dayRain"
        case "10n":
            return "nightRain"
        case "11d":
            return "dayThunderstorm"
        case "11n":
            return "nightThunderstorm"
        case "13d":
            return "daySnow"
        case "13n":
            return "nightSnow"
        case "50d":
            return "dayClearSky"
        case "50n":
            return "dayClearSky"
        default:
            return "dayClearSky"
        }
    }
}
