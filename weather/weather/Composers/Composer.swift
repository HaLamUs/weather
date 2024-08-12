//
//  Composer.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation

enum Composer {
    static func createCityViewModel() -> CityViewModel {
        let repository = WeatherRepositoryImpl()
        let useCase = FetchWeatherUseCaseImpl(repository: repository)
        return CityViewModel(fetchWeatherUseCase: useCase)
    }
}
