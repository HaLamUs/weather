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
            checkIsLovedCity()
        }
    }
    @Published var favCityIcon = "heart"
    
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
        checkIsLovedCity()
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
    
    private func checkIsLovedCity() {
        updateCityUseCase.findLovedCity(city)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                if case let .failure(error) = completion {
                    favCityIcon = "heart"
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] lovedCity in
                guard let self else { return }
                favCityIcon = lovedCity != nil ? "heart.fill" : "heart"
            })
            .store(in: &cancellables)
    }
    
    /*
     1. TODO: proper handle error
     2. TODO: Can remove the city
     */
    func saveFavCity() {
        do {
            // remove here if found
            try updateCityUseCase.save(city: city)
        } catch {
            print(error)
        }
        checkIsLovedCity()
    }
    
}

