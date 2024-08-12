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
        let fetchWeatherUseCase = FetchWeatherUseCaseImpl(repository: repository)
        
        let cityRepository = CityRepositoryImpl()
        let updateCityUseCase = UpdateCityUseCaseImpl(repository: cityRepository)
        
        let dateFormattingUseCase = DateFormattingUseCaseImpl()
        let weatherDataUseCase = WeatherDataUseCaseImpl()
        
        return CityViewModel(
            fetchWeatherUseCase: fetchWeatherUseCase,
            dateFormattingUseCase: dateFormattingUseCase,
            weatherDataUseCase: weatherDataUseCase,
            updateCityUseCase: updateCityUseCase
        )
    }
}

