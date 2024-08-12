//
//  WeatherRepository.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation

protocol WeatherRepository {
    func fetchWeather(for city: String) async throws -> WeatherResponse
}
