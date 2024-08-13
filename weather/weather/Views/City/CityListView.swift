//
//  CityListView.swift
//  weather
//
//  Created by lamha on 09/08/2024.
//

import SwiftUI

final class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItem()
        }
    }
    
    let itemsKey = "items_list"
    
    init() {
        getItems() // Call the 'getItems()' function when the class is initialized.
    }
    // Fetches data from UserDefaults and assigns it to the 'items' array.
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    func deleteItem(index: IndexSet) {
        items.remove(atOffsets: index)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to) // Perform item moving from one index to another.
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isComplated: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    // Saves the 'items' array to UserDefaults.
    func saveItem() {
        if let encodeData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.setValue(encodeData, forKey: itemsKey)
        }
    }
}

struct CityListView: View {
    @ObservedObject var listViewModel: ListViewModel
    @Binding var tabSelection: Int
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoCityView(tabSelection: $tabSelection)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            } else {
                List {
                    ForEach(listViewModel.items) { item in
                        CityRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear(duration: 0.15)) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
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
