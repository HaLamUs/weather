//
//  CityViewHeader.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct CityViewHeader: View {
    var city: String
    var date: String
    
    var body: some View {
        HStack {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                Text(city)
                    .font(.title)
                    .bold()
                Text(date)
            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    CityViewHeader(city: "Sai Gon", date: "08/08/2024")
}
