//
//  DatabaseInterface.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation

protocol DatabaseManager {
    associatedtype Entity

    func create(_ object: Entity) throws
    func read(with primaryKey: Any) -> Entity?
    func update(_ object: Entity, with dictionary: [String: Any])
    func delete(_ object: Entity)
}
