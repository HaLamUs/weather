//
//  CityViewModel.swift
//  weather
//
//  Created by lamha on 13/08/2024.
//

import Foundation
import Combine

final class CityViewModel: ObservableObject {
    // Inputs
    struct Inputs {
        let fetchCities: PassthroughSubject<Void, Never>
        let deleteCity: PassthroughSubject<String, Never>
    }
    
    // Outputs
    final class Outputs: ObservableObject {
        @Published var cities: [LovedCityDTO] = []
    }
    
    var output: Outputs?
    var input: Inputs?
    
    private var cancellables: Set<AnyCancellable> = .init()
    private let updateCityUseCase: UpdateCityUseCase
    
    init(updateCityUseCase: UpdateCityUseCase) {
        self.updateCityUseCase = updateCityUseCase
    }
    
    // TODO: handle error case
    private func removeFavCity(city: String) {
        do {
            try updateCityUseCase.remove(city: city)
        } catch {
            print(error)
        }
    }
    
    func transform(inputs: Inputs) -> Outputs {
        let output = Outputs()
        
        // Handle fetch cities input
        inputs.fetchCities
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] _ in
                guard let self else { return }
                updateCityUseCase.fetchAllLovedCities()
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        if case let .failure(error) = completion {
                            print("Error: \(error.localizedDescription)")
                        }
                    }, receiveValue: { listOfCity in
                        output.cities = listOfCity
                    })
                    .store(in: &cancellables)
            }
            .store(in: &cancellables)
        
        // Handle delete city input
        inputs.deleteCity
            .receive(on: DispatchQueue.main)
            .sink { [weak self] city in
                guard let self else { return }
                output.cities.removeAll { $0.name == city }
                removeFavCity(city: city)
            }
            .store(in: &cancellables)
        return output
    }
}


final class CityViewModel2: ObservableObject {
    @Published var cities: [LovedCityDTO] = []
    
    private var cancellables: Set<AnyCancellable> = .init()
    private let updateCityUseCase: UpdateCityUseCase
    
    init(updateCityUseCase: UpdateCityUseCase) {
        self.updateCityUseCase = updateCityUseCase
    }
    
    // TODO: handle error case
    func getCities() {
        updateCityUseCase.fetchAllLovedCities()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] listOfCity in
                guard let self else { return }
                cities = listOfCity
            })
            .store(in: &cancellables)
    }
    
    // TODO: handle error case
    private func removeFavCity(city: String) {
        do {
            try updateCityUseCase.remove(city: city)
        } catch {
            print(error)
        }
    }
    
    func deleteCity(_ city: String) {
        cities.removeAll { $0.name == city }
        removeFavCity(city: city)
    }
}
