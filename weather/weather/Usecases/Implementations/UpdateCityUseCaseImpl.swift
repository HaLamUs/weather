//
//  UpdateCityUseCaseImpl.swift
//  weather
//
//  Created by lamha on 13/08/2024.
//

import Foundation

struct UpdateCityUseCaseImpl: UpdateCityUseCase {
    
    private let repository: CityRepository
    
    init(repository: CityRepository) {
        self.repository = repository
    }
    
    func save(city: String) throws {
        try repository.saveFavCity(city)
    }
    
    
}
