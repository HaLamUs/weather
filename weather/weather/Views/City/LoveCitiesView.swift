//
//  LoveCitiesView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct LoveCitiesView: View {
    @Binding var tabSelection: Int
    @ObservedObject var listViewModel = ListViewModel()
    
    var body: some View {
        CityListView(
            listViewModel: listViewModel,
            tabSelection: $tabSelection
        )
    }
}

//#Preview {
//    @State var tabSelection = 1
//    LoveCitiesView(tabSelection: tabSelection)
//}
