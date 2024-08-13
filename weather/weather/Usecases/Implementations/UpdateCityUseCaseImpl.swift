//
//  UpdateCityUseCaseImpl.swift
//  weather
//
//  Created by lamha on 13/08/2024.
//

import Foundation
import Combine

struct UpdateCityUseCaseImpl: UpdateCityUseCase {
    
    private let repository: CityRepository
    
    init(repository: CityRepository) {
        self.repository = repository
    }
    
    func save(city: String) throws {
        try repository.saveFavCity(city)
    }
    
    func remove(city: String) throws {
        try repository.removeFavCity(city)
    }
    
    func fetchAllLovedCities() -> AnyPublisher<[LovedCityDTO], Error> {
        return repository.fetchAll()
            .map { lovedCities in
                lovedCities.map { LovedCityDTO(name: $0.name) }
            }
            .eraseToAnyPublisher()
    }
    
}
