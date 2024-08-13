//
//  CityRepository.swift
//  weather
//
//  Created by lamha on 13/08/2024.
//

import Foundation
import Combine

protocol CityRepository {
    func saveFavCity(_ city: String) throws
    func fetchAll() -> AnyPublisher<[LovedCity], Error>
}
