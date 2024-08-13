//
//  ForcastViewModel.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import Foundation
import Combine

final class ForcastViewModel: ObservableObject {
    @Published var weather = WeatherResponse.empty()
    @Published var city: String = "Ho Chi Minh" {
        didSet {
            Task {
                await fetchWeather()
            }
        }
    }
    
    private let fetchWeatherUseCase: FetchWeatherUseCase
    private let updateCityUseCase: UpdateCityUseCase
    private let dateFormattingUseCase: DateFormattingUseCase
    private let weatherDataUseCase: WeatherDataUseCase
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    init(fetchWeatherUseCase: FetchWeatherUseCase,
         dateFormattingUseCase: DateFormattingUseCase,
         weatherDataUseCase: WeatherDataUseCase,
         updateCityUseCase: UpdateCityUseCase
    ) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
        self.dateFormattingUseCase = dateFormattingUseCase
        self.weatherDataUseCase = weatherDataUseCase
        self.updateCityUseCase = updateCityUseCase
        Task {
            await fetchWeather()
        }
    }
    
    var date: String {
        dateFormattingUseCase.formatDate(timestamp: weather.current.dt)
    }
    
    var weatherAnimation: String {
        weatherDataUseCase.getWeatherAnimation(weather: weather)
    }
    
    var temperature: String {
        weatherDataUseCase.getTemperature(temp: weather.current.temp)
    }
    
    var conditions: String {
        weatherDataUseCase.getConditions(weather: weather)
    }
    
    var windSpeed: String {
        weatherDataUseCase.getWindSpeed(windSpeed: weather.current.wind_speed)
    }
    
    var humidity: String {
        weatherDataUseCase.getHumidity(humidity: weather.current.humidity)
    }
    
    var rainChances: String {
        weatherDataUseCase.getRainChances(dewPoint: weather.current.dew_point)
    }
    
    var favCityIcon: String {
        "heart.fill" //"heart"
    }
    
    func getTimeFor(timestamp: Int) -> String {
        dateFormattingUseCase.formatTime(timestamp: timestamp)
    }
    
    func getTempFor(temp: Double) -> String {
        weatherDataUseCase.getTemperature(temp: temp)
    }
    
    func getDayFor(timestamp: Int) -> String {
        dateFormattingUseCase.formatDay(timestamp: timestamp)
    }
    
    func getWeatherIconFor(icon: String) -> String {
        weatherDataUseCase.getWeatherIconFor(icon: icon)
    }
}

extension ForcastViewModel {
    // TODO: proper handle error
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
    
    // TODO: proper handle error
    func saveFavCity() {
        do {
            try updateCityUseCase.save(city: city)
        } catch {
            print(error)
        }
    }
    
    // TODO: handle error case
    func getAllCities() {
        updateCityUseCase.fetchAllLovedCities()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { info in
                print("Received cities: \(info)")
            })
            .store(in: &cancellables)
    }
    
    // TODO: handle error case
    func removeFavCity() {
        do {
            try updateCityUseCase.remove(city: city)
        } catch {
            print(error)
        }
    }
}

