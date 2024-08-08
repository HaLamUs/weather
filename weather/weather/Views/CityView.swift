//
//  CityView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct CityView: View {
    @ObservedObject var cityViewModel: CityViewModel
    
    var body: some View {
        VStack {
            CityViewHeader(city: "Sai Gon", date: "08/08/2024")
            TodayWeatherView(cityViewModel: cityViewModel)
        }
    }
}

#Preview {
    CityView(cityViewModel: CityViewModel())
}
