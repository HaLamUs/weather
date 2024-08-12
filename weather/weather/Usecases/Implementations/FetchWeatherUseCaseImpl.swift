//
//  FetchWeatherUseCaseImpl.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation

struct FetchWeatherUseCaseImpl: FetchWeatherUseCase {
    private let repository: WeatherRepository

    init(repository: WeatherRepository) {
        self.repository = repository
    }

    func execute(for city: String) async throws -> WeatherResponse {
        return try await repository.fetchWeather(for: city)
    }
}
