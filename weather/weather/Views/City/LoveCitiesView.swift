//
//  LoveCitiesView.swift
//  weather
//
//  Created by lamha on 08/08/2024.
//

import SwiftUI

struct LoveCitiesView: View {
    @ObservedObject var listViewModel = ListViewModel()
    
    var body: some View {
//        Text("Hello, World! LoveCitiesView")
        CityListView(listViewModel: listViewModel)
    }
}

#Preview {
    LoveCitiesView()
}
