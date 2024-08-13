//
//  NoCityView.swift
//  weather
//
//  Created by lamha on 09/08/2024.
//

import SwiftUI

struct NoCityView: View {
    @State private var animate = false
    @Binding var tabSelection: Int
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("No loved city found!")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Are you a weather person? I think you should click the add button and add a bunch of city to your Fav list")
                    .padding(.bottom, 20)
                
                Text("Save your favorite city 🥳")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(animate ? Color.pink : .accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, animate ? 30 : 50)
                    .shadow(
                        color: animate ? Color.pink.opacity(0.7) : .accentColor.opacity(0.7),
                        radius: animate ? 30 : 10,
                        x: 0,
                        y: animate ? 50 : 40
                    )
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .offset(y: animate ? -7 : 0)
                    .onTapGesture {
                        tabSelection = 1
                    }
            }
            .frame(maxWidth: 400) // For Landscape
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            withAnimation(
                .easeInOut(duration: 2.0)
                .repeatForever()
            ) {
                animate.toggle()
            }
        })
    }
}

//#Preview {
//    @State var currentIndex: Int = 0
//    NoCityView(tabSelection: Binding(projectedValue: $currentIndex))
//}
