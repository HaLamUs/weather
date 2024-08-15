//
//  CityHeaderView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct CityHeaderView: View {
    var forcastViewModel: ForcastViewModel
    @ObservedObject var output: ForcastViewModel.Outputs
    
    // TODO: fix force cast
    var body: some View {
        HStack {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                HStack() {
                    Text(output.city)
                        .font(.title)
                        .bold()
                    Image(systemName: output.favCityIcon)
                        .onTapGesture {
                            forcastViewModel.input?.saveFavCity.send(output.city)
                        }
                }
                Text(output.date)
            }
            .foregroundColor(.white)
        }
    }
}
