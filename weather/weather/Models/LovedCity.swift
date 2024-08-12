//
//  LovedCity.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation
import RealmSwift

class LovedCity: Object {
    @objc dynamic var id: Int64 = -1
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
