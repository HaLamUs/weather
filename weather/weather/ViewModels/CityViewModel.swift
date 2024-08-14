//
//  CityViewModel.swift
//  weather
//
//  Created by lamha on 13/08/2024.
//

import Foundation
import Combine

// TODO: make as protocol
final class CityViewModel: ObservableObject {
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
