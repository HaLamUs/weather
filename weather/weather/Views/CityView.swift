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
            CityViewHeader(city: cityViewModel.city, date: cityViewModel.date)
                .shadow(radius: 0)
            TodayWeatherView(cityViewModel: cityViewModel)
                .padding()
            HourlyWeatherView(cityViewModel: cityViewModel)
                .padding(.horizontal)
            DailyWeatherView(cityViewModel: cityViewModel)
                .padding(.horizontal)
        }
    }
}

#Preview {
    CityView(cityViewModel: CityViewModel())
}
