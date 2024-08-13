//
//  LovedCityDTO.swift
//  weather
//
//  Created by lamha on 13/08/2024.
//

import Foundation

struct LovedCityDTO: Identifiable {
    var id: String {
        "\(UUID())"
    }
    
    let name: String
}


