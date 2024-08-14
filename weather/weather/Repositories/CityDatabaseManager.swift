//
//  CityDatabaseManager.swift
//  weather
//
//  Created by lamha on 13/08/2024.
//

import Foundation
import RealmSwift
import Combine

protocol CityDatabaseManagerInterface: DatabaseManager {
    func findCity(_ city: String) -> AnyPublisher<LovedCity?, Error>
    func toggleCity(_ name: String) throws
    func removeCity(_ name: String) throws
}

// TODO: Make accessing thread safer
struct CityDatabaseManager: CityDatabaseManagerInterface {
    typealias Entity = LovedCity
    
    static let realmClient = try? RealmClient().realm
    
    func toggleCity(_ name: String) throws {
        if let city = search(city: name) {
            try delete(city)
        } else {
            try create(initLovedCityModel(name: name))
        }
    }
    
    // TODO: handle result return
    func create(_ city: LovedCity) throws {
        guard let realm = CityDatabaseManager.realmClient else {
            throw RealmClient.DatabaseError.realmClientUnavailable
        }
        do {
            try realm.write {
                realm.add(city)
            }
        } catch {
            throw RealmClient.DatabaseError.createFailed
        }
    }
    
    func fetchAll() -> AnyPublisher<[LovedCity], Error> {
        Future { promise in
            guard let realm = CityDatabaseManager.realmClient else {
                return promise(.failure(RealmClient.DatabaseError.realmClientUnavailable))
            }
            let results = realm.objects(LovedCity.self)
            let lovedCities = Array(results)
            promise(.success(lovedCities))
            
        }.eraseToAnyPublisher()
    }
    
    func update(_ object: LovedCity, with dictionary: [String : Any]) {
        
    }
    
    func removeCity(_ name: String) throws {
        try delete(initLovedCityModel(name: name))
    }
    
    func delete(_ object: LovedCity) throws {
        if let city = search(city: object.name) {
            guard let realm = CityDatabaseManager.realmClient else {
                throw RealmClient.DatabaseError.realmClientUnavailable
            }
            do {
                try realm.write {
                    realm.delete(realm.objects(LovedCity.self).filter("id == %@", city.id))
                }
            } catch {
                throw RealmClient.DatabaseError.deleteFailed
            }
        }
    }
    
    func findCity(_ city: String) -> AnyPublisher<LovedCity?, Error> {
        Future { promise in
            guard let realm = CityDatabaseManager.realmClient else {
                return promise(.failure(RealmClient.DatabaseError.realmClientUnavailable))
            }
            let lovedCity = realm
                .objects(LovedCity.self)
                .filter("name == %@", city)
                .first
            promise(.success(lovedCity))
            
        }.eraseToAnyPublisher()
    }
}

extension CityDatabaseManager {
    private func search(city: String) -> LovedCity? {
        CityDatabaseManager.realmClient?
            .objects(LovedCity.self)
            .filter("name == %@", city)
            .first
    }
    
    private func incrementID() -> Int {
        (CityDatabaseManager.realmClient?
            .objects(LovedCity.self)
            .max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    private func initLovedCityModel(name: String) -> LovedCity {
        let city = LovedCity()
        city.name = name
        city.id = incrementID()
        return city
    }
}
