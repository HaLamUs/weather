//
//  Test.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation

final class CityViewModel: ObservableObject {
    @Published var weather = WeatherResponse.empty()
    @Published var city: String = "Ho Chi Minh" {
        didSet {
            Task {
                await fetchWeather()
            }
        }
    }

    private let fetchWeatherUseCase: FetchWeatherUseCase

    init(fetchWeatherUseCase: FetchWeatherUseCase) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
        Task {
            await fetchWeather()
        }
    }

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()

    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()

    var date: String {
        dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }

    var weatherIcon: String {
        weather.current.weather.first?.icon ?? "dayClearSky"
    }

    var temperature: String {
        getTempFor(temp: weather.current.temp)
    }

    var conditions: String {
        weather.current.weather.first?.main ?? ""
    }

    var windSpeed: String {
        String(format: "%0.1f", weather.current.wind_speed)
    }

    var humidity: String {
        String(format: "%d%%", weather.current.humidity)
    }

    var rainChances: String {
        String(format: "%0.1f%%", weather.current.dew_point)
    }

    func getTimeFor(timestamp: Int) -> String {
        timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }

    func getTempFor(temp: Double) -> String {
        String(format: "%0.1f", temp)
    }

    func getDayFor(timestamp: Int) -> String {
        dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }

    private func fetchWeather() async {
        do {
            let response = try await fetchWeatherUseCase.execute(for: city)
            DispatchQueue.main.async {
                self.weather = response
            }
        } catch {
            print(error)
        }
    }

    func getLottieAnimationFor(icon: String) -> String {
        switch icon {
        case "01d":
            return "dayClearSky"
        case "01n":
            return "nightClearSky"
        case "02d":
            return "dayFewClouds"
        default:
            return "dayClearSky"
        }
    }

    func getWeatherIconFor(icon: String) -> String {
        switch icon {
        case "01d":
            return "sun.max.fill"
        case "01n":
            return "moon.fill"
        case "02d":
            return "cloud.sun.fill"
        default:
            return "sun.max.fill"
        }
    }
}

