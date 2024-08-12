//
//  CityHeaderView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct CityHeaderView: View {
    @ObservedObject var cityViewModel: CityViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                HStack() {
                    Text(cityViewModel.city)
                        .font(.title)
                        .bold()
                    Image(systemName: cityViewModel.favCityIcon)
                        .onTapGesture {
                            cityViewModel.saveFavCity()
                        }
                }
                Text(cityViewModel.date)
            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    CityHeaderView(cityViewModel: Composer.createCityViewModel())
}
