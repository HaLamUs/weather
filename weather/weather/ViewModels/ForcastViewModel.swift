//
//  ForcastViewModel.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import Foundation
import Combine

final class ForcastViewModel {
    // Inputs
    struct Inputs {
        let fetchWeather: PassthroughSubject<String, Never>
        let city: PassthroughSubject<String, Never>
        let saveFavCity: PassthroughSubject<String, Never>
    }
    
    // Outputs
    final class Outputs: ObservableObject {
        @Published var weather = WeatherResponse.empty()
        @Published var favCityIcon = "heart"
        @Published var city: String = "Ho Chi Minh"
        var date: String = ""
        var weatherAnimation: String = ""
        var temperature: String = ""
        var conditions: String = ""
        var windSpeed: String = ""
        var humidity: String = ""
        var rainChances: String = ""
    }
    
    var output: Outputs!
    var input: Inputs?
    
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
    }
    
    func transform(inputs: Inputs) -> Outputs {
        let output = Outputs()
        // Handle fetch weather input
        inputs.fetchWeather
            .sink{ [weak self] city in
                guard let self else { return }
                Task {
                    do {
                        let weather = try await self.fetchWeatherUseCase.execute(for: city)
                        await MainActor.run {
                            output.city = city
                            self.fillOutput(weather: weather)
                        }
                    } catch {
                        print(error)
                    }
                }
                self.checkIsLovedCity(city: city)
            }
            .store(in: &cancellables)
        
        // Handle save favorite city input
        inputs.saveFavCity
            .sink { [weak self] _ in
                guard let self else { return }
                saveFavCity(city: output.city)
            }
            .store(in: &cancellables)
        
        return output
    }
}

extension ForcastViewModel {
    // TODO: proper handle error
    private func saveFavCity(city: String) {
        do {
            try updateCityUseCase.toggle(city: city)
        } catch {
            print(error)
        }
        checkIsLovedCity(city: city)
    }
    
    private func checkIsLovedCity(city: String) {
        updateCityUseCase.findLovedCity(city)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                if case let .failure(error) = completion {
                    output?.favCityIcon = "heart"
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] lovedCity in
                guard let self else { return }
                output?.favCityIcon = lovedCity != nil ? "heart.fill" : "heart"
            })
            .store(in: &cancellables)
    }
    
    private func fillOutput(weather: WeatherResponse) {
        output?.weather = weather
        output?.date = dateFormattingUseCase.formatDate(timestamp: weather.current.dt)
        
        output?.weatherAnimation = weatherDataUseCase.getWeatherAnimation(weather: weather)
        output?.temperature = weatherDataUseCase.getTemperature(temp: weather.current.temp)
        output?.conditions = weatherDataUseCase.getConditions(weather: weather)
        output?.windSpeed = weatherDataUseCase.getWindSpeed(windSpeed: weather.current.wind_speed)
        output?.humidity = weatherDataUseCase.getHumidity(humidity: weather.current.humidity)
        output?.rainChances = weatherDataUseCase.getRainChances(dewPoint: weather.current.dew_point)
        
    }
}

extension ForcastViewModel {
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


