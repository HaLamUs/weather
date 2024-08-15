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
    
    func toggleCity(_ city: String) throws {
        try cityDataManager.toggleCity(city)
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
