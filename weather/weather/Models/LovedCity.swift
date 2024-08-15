//
//  LovedCity.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation
import RealmSwift

class LovedCity: Object {
    @Persisted(primaryKey: true) var id: Int = -1
    @Persisted var name: String = ""
}
