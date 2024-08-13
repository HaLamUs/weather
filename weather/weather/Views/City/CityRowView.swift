//
//  CityRowView.swift
//  weather
//
//  Created by lamha on 09/08/2024.
//

import SwiftUI

struct CityRowView: View {
    let city: LovedCityDTO
    
    var body: some View {
        HStack {
            Text(city.name)
            Spacer()
        }
    }
}

#Preview {
    CityRowView(city: LovedCityDTO(name: "Ho Chi Minh"))
}
