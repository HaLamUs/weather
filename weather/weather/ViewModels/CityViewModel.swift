//
//  CityViewModel.swift
//  weather
//
//  Created by lamha on 13/08/2024.
//

import Foundation
import Combine

// TODO: make as protocol
final class CityViewModel: ObservableObject {
    @Published var cities: [LovedCityDTO] = []
    
    private var cancellables: Set<AnyCancellable> = .init()
    private let updateCityUseCase: UpdateCityUseCase
    
    init(updateCityUseCase: UpdateCityUseCase) {
        self.updateCityUseCase = updateCityUseCase
        getCities()
    }
    
    // TODO: handle error case
    func getCities() {
        updateCityUseCase.fetchAllLovedCities()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] listOfCity in
                guard let self else { return }
                cities = listOfCity
            })
            .store(in: &cancellables)
    }
    
    // TODO: handle error case
    private func removeFavCity(city: String) {
        do {
            try updateCityUseCase.remove(city: city)
        } catch {
            print(error)
        }
    }
    
    func deleteItem(index: IndexSet) {
        if let city = index.map({ cities[$0].name }).first {
            removeFavCity(city: city)
        }
    }
}

// ===================
struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isComplated: Bool
    
    init(id: String = UUID().uuidString, title: String, isComplated: Bool) {
        self.id = id
        self.title = title
        self.isComplated = isComplated
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isComplated: !isComplated)
    }
}


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
