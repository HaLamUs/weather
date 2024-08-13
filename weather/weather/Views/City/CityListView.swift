//
//  CityListView.swift
//  weather
//
//  Created by lamha on 09/08/2024.
//

import SwiftUI

struct CityListView: View {
    @ObservedObject var listViewModel: ListViewModel
    @ObservedObject var cityViewModel: CityViewModel
    @Binding var tabSelection: Int
    
    var body: some View {
        ZStack {
            if cityViewModel.cities.isEmpty {
                NoCityView(tabSelection: $tabSelection)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            } else {
                List {
                    ForEach(cityViewModel.cities) { city in
                        CityRowView(city: city)
//                            .onTapGesture {
//                                withAnimation(.linear(duration: 0.15)) {
//                                    listViewModel.updateItem(item: city)
//                                }
//                            }
                    }
                    .onDelete(perform: cityViewModel.deleteItem)
//                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(.plain)
            }
        }
    }
}

//#Preview {
//    @State var tabSelection = 1
//    CityListView(
//        listViewModel: ListViewModel(),
//        tabSelection: $tabSelection
//    )
//}
