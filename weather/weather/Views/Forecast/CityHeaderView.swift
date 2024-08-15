//
//  CityHeaderView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct CityHeaderView: View {
    var forcastViewModel: ForcastViewModel
    
    // TODO: fix force cast
    var body: some View {
        HStack {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                HStack() {
                    Text(forcastViewModel.output!.city)
                        .font(.title)
                        .bold()
                    Image(systemName: forcastViewModel.output!.favCityIcon)
                        .onTapGesture {
                            forcastViewModel.input?.saveFavCity.send(forcastViewModel.output!.city)
//                            forcastViewModel.saveFavCity()
                        }
                }
                Text(forcastViewModel.output!.date)
            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    CityHeaderView(forcastViewModel: Composer.createForcastViewModel())
}
