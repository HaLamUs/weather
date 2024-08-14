//
//  UpdateCityUseCase.swift
//  weather
//
//  Created by lamha on 13/08/2024.
//

import Foundation
import Combine

protocol UpdateCityUseCase {
    func save(city: String) throws
    func remove(city: String) throws
    func fetchAllLovedCities() -> AnyPublisher<[LovedCityDTO], Error>
    func findLovedCity(_ city: String) -> AnyPublisher<LovedCityDTO?, Error>
}
