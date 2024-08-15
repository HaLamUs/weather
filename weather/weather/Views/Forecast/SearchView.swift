//
//  SearchView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var forcastViewModel: ForcastViewModel
    @State private var searchTerm = ""
    
    var body: some View {
        HStack {
            TextField("", text: $searchTerm)
                .accentColor(.yellow)
                .padding(.vertical, 5)
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                )
                .onTapGesture {
                    forcastViewModel.city = searchTerm
                }
        }
        .foregroundColor(.white)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue]),
                    startPoint: .top,
                    endPoint: .bottom))
                .opacity(0.3)
        )
        .onAppear {
            searchTerm = forcastViewModel.city
            forcastViewModel.city = searchTerm // trigger update
        }
    }
}

#Preview {
    SearchView(forcastViewModel: Composer.createForcastViewModel())
}
