//
//  CityDatabaseManager.swift
//  weather
//
//  Created by lamha on 13/08/2024.
//

import Foundation
import RealmSwift
import Combine

enum CityDatabaseError: Error {
    case realmClientUnavailable
    case writeFailed
}

protocol CityDatabaseManagerInterface: DatabaseManager {
    func saveCity(_ name: String) throws
}

// TODO: Make accessing thread safer
struct CityDatabaseManager: CityDatabaseManagerInterface {
    typealias Entity = LovedCity
   
    static let realmClient = try? RealmClient().realm
    
    func saveCity(_ name: String) throws {
        let city = LovedCity()
        city.name = name
        city.id = incrementID()
        try create(city)
    }
    
    // TODO: handle result return
    func create(_ object: LovedCity) throws {
        let city = search(city: object.name)
        if city == nil {
            guard let realm = CityDatabaseManager.realmClient else {
                throw CityDatabaseError.realmClientUnavailable
            }
            do {
                try realm.write {
                    realm.add(object)
                }
            } catch {
                throw CityDatabaseError.writeFailed
            }
        }
    }
    
    func fetchAll() -> AnyPublisher<[LovedCity], Error> {
        Future { promise in
            guard let realm = CityDatabaseManager.realmClient else {
                return promise(.failure(CityDatabaseError.realmClientUnavailable))
            }
            let results = realm.objects(LovedCity.self)
            let lovedCities = Array(results)
            promise(.success(lovedCities))
            
        }.eraseToAnyPublisher()
    }
    
    func update(_ object: LovedCity, with dictionary: [String : Any]) {
        
    }
    
    func delete(_ object: LovedCity) {
        
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
}
