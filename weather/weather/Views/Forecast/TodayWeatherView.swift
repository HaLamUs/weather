//
//  TodayWeatherView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct TodayWeatherView: View {
    @ObservedObject var output: ForcastViewModel.Outputs
    
    // TODO: Fix force cast
    var body: some View {
        VStack(spacing: 10) {
            Text("Today")
                .font(.largeTitle)
                .bold()
            
            HStack(spacing: 20) {
                LottieView(name: output.weatherAnimation)
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    Text("\(output.temperature)℃")
                        .font(.system(size: 42))
                    Text(output.conditions)
                }
            }
            
            HStack {
                Spacer()
                widgetView(image: "wind", color: .green, title: "\(output.windSpeed) km/hr")
                Spacer()
                widgetView(image: "drop.fill", color: .blue, title: "\(output.humidity)")
                Spacer()
                widgetView(image: "umbrella.fill", color: .red, title: "\(output.rainChances)")
                Spacer()
            }
        }
        .padding()
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue]),
                    startPoint: .top,
                    endPoint: .bottom))
                .opacity(0.3)
        )
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
    }
    
    private func widgetView(image: String, color: Color, title: String) -> some View {
        VStack {
            Image(systemName: image)
                .padding()
                .font(.title)
                .foregroundColor(color)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            
            Text(title)
        }
    }
}

//#Preview {
//    TodayWeatherView(forcastViewModel: Composer.createForcastViewModel())
//}
