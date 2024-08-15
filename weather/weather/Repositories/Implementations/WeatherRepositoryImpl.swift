//
//  WeatherRepositoryImpl.swift
//  weather
//
//  Created by lamha on 12/08/2024.
//

import Foundation
import CoreLocation

struct WeatherRepositoryImpl: WeatherRepository {
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        return try await withCheckedThrowingContinuation { continuation in
            CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
                if let places = placemarks, let place = places.first {
                    let coord = place.location?.coordinate
                    let urlString = Api.getUrlFor(lat: coord?.latitude ?? 0, lon: coord?.longitude ?? 0)
                    NetworkManager<WeatherResponse>.fetch(for: URL(string: urlString)!) { result in
                        switch result {
                        case .success(let response):
                            continuation.resume(returning: response)
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        }
                    }
                } else if let error = error {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
