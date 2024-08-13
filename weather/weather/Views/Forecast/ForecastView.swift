//
//  ForecastView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct ForecastView: View {
    @ObservedObject var forcastViewModel = Composer.createForcastViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                SearchView(forcastViewModel: forcastViewModel)
                    .padding(.horizontal, 10)
                ScrollView(showsIndicators: false) {
                    CityView(forcastViewModel: forcastViewModel)
                        .padding(.top, 10)
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
    }
}

#Preview {
    ForecastView()
}
