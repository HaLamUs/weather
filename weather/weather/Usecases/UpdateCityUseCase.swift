//
//  UpdateCityUseCase.swift
//  weather
//
//  Created by lamha on 13/08/2024.
//

import Foundation

protocol UpdateCityUseCase {
    func save(city: String) throws
}
