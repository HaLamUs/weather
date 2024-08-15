//
//  CityView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct CityView: View {
    var forcastViewModel: ForcastViewModel
    
    var body: some View {
        VStack {
            CityHeaderView(forcastViewModel: forcastViewModel)
                .shadow(radius: 0)
            TodayWeatherView(output: forcastViewModel.output!)
                .padding()
            HourlyWeatherView(
                forcastViewModel: forcastViewModel,
                output: forcastViewModel.output!
            )
            .padding(.horizontal)
            DailyWeatherView(
                forcastViewModel: forcastViewModel,
                output: forcastViewModel.output!
            )
            .padding(.horizontal)
        }
    }
}

#Preview {
    CityView(forcastViewModel: Composer.createForcastViewModel())
}
