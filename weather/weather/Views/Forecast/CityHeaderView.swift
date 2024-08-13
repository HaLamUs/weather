//
//  CityHeaderView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct CityHeaderView: View {
    @ObservedObject var forcastViewModel: ForcastViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                HStack() {
                    Text(forcastViewModel.city)
                        .font(.title)
                        .bold()
                    Image(systemName: forcastViewModel.favCityIcon)
                        .onTapGesture {
                            forcastViewModel.saveFavCity()
//                            cityViewModel.getAllCities()
//                            cityViewModel.removeFavCity()
                        }
                }
                Text(forcastViewModel.date)
            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    CityHeaderView(forcastViewModel: Composer.createForcastViewModel())
}
