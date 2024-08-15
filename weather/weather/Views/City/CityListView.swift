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
    @Binding var searchCityText: String
    
    var body: some View {
        VStack() {
            if cityViewModel.cities.isEmpty {
                NoCitiesView(tabSelection: $tabSelection)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            } else {
                Text("My favourite list")
                    .foregroundStyle(.white)
                    .font(.title)
                    .bold()
                ForEach(cityViewModel.cities) { city in
                    LazyVStack {
                        CityRowView(
                            cityViewModel: cityViewModel,
                            tabSelection: $tabSelection, 
                            searchCityText: $searchCityText,
                            city: city)
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
