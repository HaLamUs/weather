//
//  CityRowView.swift
//  weather
//
//  Created by lamha on 09/08/2024.
//

import SwiftUI

struct CityRowView: View {
    var cityViewModel: CityViewModel
    @Binding var tabSelection: Int
    @Binding var searchCityText: String
    
    let city: LovedCityDTO
    
    var body: some View {
        HStack {
            Text(city.name)
                .font(.title2)
            Spacer()
            Image(systemName: "delete.backward.fill")
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                )
                .onTapGesture {
                    cityViewModel.input?.deleteCity.send(city.name)
                }
        }
        .foregroundColor(.white)
        .padding(.horizontal, 40)
        .padding(.vertical, 15)
        .background(RoundedRectangle(cornerRadius: 20)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6050806046, green: 0.8078469634, blue: 0.9820559621, alpha: 1)), Color(#colorLiteral(red: 0.4196078431, green: 0.5333333333, blue: 0.937254902, alpha: 1))]),
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )))
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
        .onTapGesture {
            searchCityText = city.name
            tabSelection = 1
        }
    }
}
