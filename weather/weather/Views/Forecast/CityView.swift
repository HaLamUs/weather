//
//  CityView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct CityView: View {
    @ObservedObject var forcastViewModel: ForcastViewModel
    
    var body: some View {
        VStack {
            CityHeaderView(forcastViewModel: forcastViewModel)
                .shadow(radius: 0)
            TodayWeatherView(forcastViewModel: forcastViewModel)
                .padding()
            HourlyWeatherView(forcastViewModel: forcastViewModel)
                .padding(.horizontal)
            DailyWeatherView(forcastViewModel: forcastViewModel)
                .padding(.horizontal)
        }
    }
}

#Preview {
    CityView(forcastViewModel: Composer.createForcastViewModel())
}
