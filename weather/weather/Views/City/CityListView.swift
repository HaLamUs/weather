//
//  CityListView.swift
//  weather
//
//  Created by lamha on 09/08/2024.
//

import SwiftUI

struct CityListView: View {
    @ObservedObject var listViewModel: ListViewModel
    @ObservedObject var cityViewModel: CityViewModel
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack() {
            if cityViewModel.cities.isEmpty {
                NoCityView(tabSelection: $tabSelection)
//                    .transition(AnyTransition.opacity.animation(.easeInOut))
            } else {
                //                List {
                ForEach(cityViewModel.cities) { city in
                    LazyVStack {
                        CityRowView(cityViewModel: cityViewModel, city: city)
                    }
                    //                    }
                    //                    .onDelete(perform: cityViewModel.deleteItem)
                }
                //                .listStyle(.plain)
            }
            Spacer()
        }
        .padding()
        .onAppear {
            cityViewModel.getCities()
        }
    }
}
