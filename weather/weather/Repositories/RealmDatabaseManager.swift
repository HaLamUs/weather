//
//  RealmDatabaseManager.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation
import RealmSwift

struct RealmDatabaseManager: DatabaseManager {
    typealias Entity = Object
    private static let schemaVersion: UInt64 = 1
    private var realm: Realm
    
    init() throws {
        let config = Realm.Configuration(
            fileURL: Realm.Configuration().fileURL?.deletingLastPathComponent()
                .appendingPathComponent("weather.realm"),
            schemaVersion: RealmDatabaseManager.schemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    // Perform migrations if needed
                }
            },
            objectTypes: [LovedCity.self]
        )
        do {
            realm = try Realm(configuration: config)
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    
    func create(_ object: Object) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Failed to create object: \(error.localizedDescription)")
        }
    }
    
    func read(with primaryKey: Any) -> Object? {
        return realm.object(ofType: Object.self, forPrimaryKey: primaryKey)
    }
    
    func update(_ object: Object, with dictionary: [String: Any]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print("Failed to update object: \(error.localizedDescription)")
        }
    }
    
    func delete(_ object: Object) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Failed to delete object: \(error.localizedDescription)")
        }
    }
}
