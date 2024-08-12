//
//  RealmClient.swift
//  weather
//
//  Created by lamha on 13/08/2024.
//

import Foundation
import RealmSwift

struct RealmClient {
    private static let schemaVersion: UInt64 = 1
    private var _realm: Realm
    
    init() throws {
        let config = Realm.Configuration(
            fileURL: Realm.Configuration().fileURL?.deletingLastPathComponent()
                .appendingPathComponent("weather.realm"),
            schemaVersion: RealmClient.schemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    // Perform migrations if needed
                }
            },
            objectTypes: [LovedCity.self]
        )
        do {
            _realm = try Realm(configuration: config)
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    var realm: Realm { _realm }
}
