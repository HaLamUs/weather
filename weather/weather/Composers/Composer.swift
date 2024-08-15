//
//  Composer.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation
import Combine

enum Composer {
    
    static func createForcastViewModel() -> ForcastViewModel {
        let repository = WeatherRepositoryImpl()
        let fetchWeatherUseCase = FetchWeatherUseCaseImpl(repository: repository)
        
        let cityRepository = CityRepositoryImpl()
        let updateCityUseCase = UpdateCityUseCaseImpl(repository: cityRepository)
        
        let dateFormattingUseCase = DateFormattingUseCaseImpl()
        let weatherDataUseCase = WeatherDataUseCaseImpl()
        
        
        let inputs = ForcastViewModel.Inputs(
            fetchWeather: PassthroughSubject<String, Never>(),
            city: PassthroughSubject<String, Never>(),
            saveFavCity: PassthroughSubject<String, Never>()
        )
        
        let vm = ForcastViewModel(
            fetchWeatherUseCase: fetchWeatherUseCase,
            dateFormattingUseCase: dateFormattingUseCase,
            weatherDataUseCase: weatherDataUseCase,
            updateCityUseCase: updateCityUseCase
        )
        let output = vm.transform(inputs: inputs)
        vm.input = inputs
        vm.output = output
        
        return vm
    }
    
    static func createCityViewModel() -> CityViewModel {
        let inputs = CityViewModel.Inputs(
            fetchCities: PassthroughSubject<Void, Never>(),
            deleteCity: PassthroughSubject<String, Never>()
        )
        let cityRepository = CityRepositoryImpl()
        let updateCityUseCase = UpdateCityUseCaseImpl(repository: cityRepository)
        let viewModel = CityViewModel(updateCityUseCase: updateCityUseCase)
        let output = viewModel.transform(inputs: inputs)
        viewModel.input = inputs
        viewModel.output = output
        return viewModel
    }
}

