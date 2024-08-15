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
            CityHeaderView(
                forcastViewModel: forcastViewModel,
                output: forcastViewModel.output!
            )
            .shadow(radius: 0)
            TodayWeatherView(output: forcastViewModel.output!)
                .padding()
            HourlyWeatherView(
                forcastViewModel: forcastViewModel,
                output: forcastViewModel.output!
            )
            .padding()
            DailyWeatherView(
                forcastViewModel: forcastViewModel,
                output: forcastViewModel.output!
            )
            .padding()
        }
    }
}

#Preview {
    CityView(forcastViewModel: Composer.createForcastViewModel())
}
