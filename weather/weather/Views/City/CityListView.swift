//
//  CityListView.swift
//  weather
//
//  Created by lamha on 09/08/2024.
//

import SwiftUI

struct CityListView: View {
    var cityViewModel: CityViewModel
    @ObservedObject var output: CityViewModel.Outputs
    
    @Binding var tabSelection: Int
    @Binding var searchCityText: String
    
    var body: some View {
        VStack() {
            if output.cities.isEmpty {
                NoCitiesView(tabSelection: $tabSelection)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            } else {
                Text("My favourite list")
                    .foregroundStyle(.white)
                    .font(.title)
                    .bold()
                ForEach(output.cities) { city in
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
            cityViewModel.input?.fetchCities.send()
        }
    }
}
