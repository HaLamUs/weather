//
//  FetchWeatherUseCase.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation

protocol FetchWeatherUseCase {
    func execute(for city: String) async throws -> WeatherResponse
}
