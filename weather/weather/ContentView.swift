//
//  ContentView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ForecastView()
                .tabItem {
                    Label("Forecast", systemImage: "cloud.sun.fill")
                }
                .tag(1)
            LoveCitiesView(tabSelection: $tabSelection)
                .tabItem {
                    Label("Love cities", systemImage: "heart")
                }
                .tag(2)
        }
    }
}

#Preview {
    ContentView()
}
