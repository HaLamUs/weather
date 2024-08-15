//
//  ContentView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    @State var forcastViewModel = Composer.createForcastViewModel()
    
    // TODO: Fix force cast
    var body: some View {
        TabView(selection: $tabSelection) {
            ForecastView(forcastViewModel: forcastViewModel)
                .tabItem {
                    Label("Forecast", systemImage: "cloud.sun.fill")
                }
                .tag(1)
            LoveCitiesView(
                tabSelection: $tabSelection,
                searchCityText: $forcastViewModel.output.city)
                .tabItem {
                    Label("Love cities", systemImage: "heart")
                }
                .tag(2)
        }
    }
}
