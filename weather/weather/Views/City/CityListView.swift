//
//  CityListView.swift
//  weather
//
//  Created by lamha on 09/08/2024.
//

import SwiftUI

struct CityListView: View {
    @ObservedObject var cityViewModel: CityViewModel
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack() {
            if cityViewModel.cities.isEmpty {
                NoCitiesView(tabSelection: $tabSelection)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            } else {
                ForEach(cityViewModel.cities) { city in
                    LazyVStack {
                        CityRowView(cityViewModel: cityViewModel, city: city)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .onAppear {
            cityViewModel.getCities()
        }
    }
}
