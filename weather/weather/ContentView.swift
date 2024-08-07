//
//  ContentView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ForecastView()
                .tabItem {
                    Label("Forecast", systemImage: "cloud.sun.fill")
                }
            LoveCitiesView()
                .tabItem {
                    Label("Love cities", systemImage: "heart")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
