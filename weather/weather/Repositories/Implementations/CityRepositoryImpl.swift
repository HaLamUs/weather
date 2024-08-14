//
//  CityRepositoryImpl.swift
//  weather
//
//  Created by lamha on 13/08/2024.
//

import Foundation
import Combine

struct CityRepositoryImpl: CityRepository {
    private let cityDataManager = CityDatabaseManager()
    
    func saveFavCity(_ city: String) throws {
        try cityDataManager.saveCity(city)
    }
    
    func removeFavCity(_ city: String) throws {
        try cityDataManager.removeCity(city)
    }
    
    func fetchAll() -> AnyPublisher<[LovedCity], Error> {
        cityDataManager.fetchAll()
    }
    
    func findCity(_ city: String) -> AnyPublisher<LovedCity?, Error> {
        cityDataManager.findCity(city)
    }
}
