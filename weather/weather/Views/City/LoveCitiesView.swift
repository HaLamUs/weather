//
//  LoveCitiesView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct LoveCitiesView: View {
    @ObservedObject var cityViewModel = Composer.createCityViewModel()
    @Binding var tabSelection: Int
    @Binding var searchCityText: String
    
    // TODO: fix force cast
    var body: some View {
        CityListView(
            cityViewModel: cityViewModel, 
            output: cityViewModel.output!,
            tabSelection: $tabSelection,
            searchCityText: $searchCityText
        )
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
    }
}
