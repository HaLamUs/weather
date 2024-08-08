//
//  ForecastView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct ForecastView: View {
    var body: some View {
        VStack(spacing: 0) {
            SearchView()
            ScrollView(showsIndicators: false) {
                CityView()
//                    .padding(.top, 10)
            }
        }
    }
}

#Preview {
    ForecastView()
}
