//
//  CityRepositoryImpl.swift
//  weather
//
//  Created by lamha on 13/08/2024.
//

import Foundation

struct CityRepositoryImpl: CityRepository {
    
    private let cityDataManager = CityDatabaseManager()
    
    func saveFavCity(_ city: String) throws {
        try cityDataManager.saveCity(city)
    }
    
    
}
