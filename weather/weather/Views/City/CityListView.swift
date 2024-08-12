//
//  CityListView.swift
//  weather
//
//  Created by lamha on 09/08/2024.
//

import SwiftUI
//
//struct CityListView2: View {
//    Text("Hello, World! LoveCitiesView")
//}

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
        items.remove(atOffsets: index) // Perform item deletion at the specified index.
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
//    @ObservedObject var cityViewModel: CityViewModel
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoCityView()
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            } else {
                List {
                    // Iterate through the items in the listViewModel and display each item using ListRowView.
                    ForEach(listViewModel.items) { item in
                        CityRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear(duration: 0.15)) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    // Enable item deletion by swiping and performing the deleteItem function from listViewModel.
                    .onDelete(perform: listViewModel.deleteItem)
                    // Enable item reordering by long-pressing and moving the item with the moveItem function from listViewModel.
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(.plain)
            }
        }
//        .navigationTitle("ToDo List 📝")
    }
}

#Preview {
    CityListView(listViewModel: ListViewModel())
}
