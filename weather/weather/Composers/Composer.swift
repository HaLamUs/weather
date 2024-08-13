//
//  Composer.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation

enum Composer {
    static func createForcastViewModel() -> ForcastViewModel {
        let repository = WeatherRepositoryImpl()
        let fetchWeatherUseCase = FetchWeatherUseCaseImpl(repository: repository)
        
        let cityRepository = CityRepositoryImpl()
        let updateCityUseCase = UpdateCityUseCaseImpl(repository: cityRepository)
        
        let dateFormattingUseCase = DateFormattingUseCaseImpl()
        let weatherDataUseCase = WeatherDataUseCaseImpl()
        
        return ForcastViewModel(
            fetchWeatherUseCase: fetchWeatherUseCase,
            dateFormattingUseCase: dateFormattingUseCase,
            weatherDataUseCase: weatherDataUseCase,
            updateCityUseCase: updateCityUseCase
        )
    }
    
    static func createCityViewModel() -> CityViewModel {
        let cityRepository = CityRepositoryImpl()
        let updateCityUseCase = UpdateCityUseCaseImpl(repository: cityRepository)
        
        return CityViewModel(updateCityUseCase: updateCityUseCase)
    }
}

