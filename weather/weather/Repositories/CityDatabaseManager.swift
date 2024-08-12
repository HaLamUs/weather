//
//  CityDatabaseManager.swift
//  weather
//
//  Created by lamha on 13/08/2024.
//

import Foundation
import RealmSwift

enum CityDatabaseError: Error {
    case realmClientUnavailable
    case writeFailed
}

protocol CityDatabaseManagerInterface: DatabaseManager {
    func saveCity(_ name: String) throws
}

struct CityDatabaseManager: CityDatabaseManagerInterface {
    typealias Entity = LovedCity
   
    static let realmClient = try? RealmClient().realm
    
    func saveCity(_ name: String) throws {
        let city = LovedCity()
        city.name = name
        city.id = incrementID()
        try create(city)
    }
    
    //TODO: handle result return
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
    
    func read(with primaryKey: Any) -> LovedCity? {
        nil
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
