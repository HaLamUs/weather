//
//  TodayWeatherView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct TodayWeatherView: View {
    @ObservedObject var cityViewModel: CityViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Today")
                .font(.largeTitle)
                .bold()
            
            VStack(spacing: 20) {
//                LottieView(name: cityViewModel.getLottieAnimationFor(icon: cityViewModel.weatherIcon))
//                    .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    Text("\(cityViewModel.temperature)℃")
                        .font(.system(size: 42))
                    Text(cityViewModel.conditions)
                }
            }
            
//            List{
//                VStack(spacing: 20) {
//                    LottieView(name: "dayClearSky")
//                        .frame(width: 100, height: 100)
//                    LottieView(name: "nightClearSky")
//                        .frame(width: 100, height: 100)
//                    LottieView(name: "dayFewClouds")
//                        .frame(width: 100, height: 100)
//                    LottieView(name: "nightFewClouds")
//                        .frame(width: 100, height: 100)
//                    LottieView(name: "dayScatteredClouds")
//                        .frame(width: 100, height: 100)
//                    LottieView(name: "nightScatteredClouds")
//                        .frame(width: 100, height: 100)
//                    LottieView(name: "dayBrokenClouds")
//                        .frame(width: 100, height: 100)
//                    LottieView(name: "nightBrokenClouds")
//                        .frame(width: 100, height: 100)
//
//                    LottieView(name: "dayShowerRains")
//                        .frame(width: 100, height: 100)
//                    LottieView(name: "nightShowerRains")
//                        .frame(width: 100, height: 100)
//
//                    LottieView(name: "dayRain")
//                        .frame(width: 100, height: 100)
//                    LottieView(name: "nightRain")
//                        .frame(width: 100, height: 100)
//                    LottieView(name: "dayThunderstorm")
//                        .frame(width: 100, height: 100)
//                    LottieView(name: "nightThunderstorm")
//                        .frame(width: 100, height: 100)
//                    LottieView(name: "daySnow")
//                        .frame(width: 100, height: 100)
//                    LottieView(name: "nightSnow")
//                        .frame(width: 100, height: 100)
//                    LottieView(name: "dayClearSky")
//                        .frame(width: 100, height: 100)
//                    LottieView(name: "nightShowerRains")
//                        .frame(width: 100, height: 100)
//                }
////                VStack(alignment: .leading) {
////                    Text("\(cityViewModel.temperature)℃")
////                        .font(.system(size: 42))
////                    Text(cityViewModel.conditions)
////                }
//            }
            HStack {
                Spacer()
                widgetView(image: "wind", color: .green, title: "\(cityViewModel.windSpeed) km/hr")
                Spacer()
                widgetView(image: "drop.fill", color: .blue, title: "\(cityViewModel.humidity)")
                Spacer()
                widgetView(image: "umbrella.fill", color: .red, title: "\(cityViewModel.rainChances)")
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

#Preview {
    TodayWeatherView(cityViewModel: CityViewModel())
}
