//
//  CityRowView.swift
//  weather
//
//  Created by lamha on 09/08/2024.
//

import SwiftUI

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


struct CityRowView: View {
    let item: ItemModel
    
    var body: some View {
        HStack {
            // Display an image based on whether 'item' is completed or not.
            Image(systemName: item.isComplated ? "checkmark.circle" : "circle")
                .foregroundStyle(item.isComplated ? .green : .red) // Set the foreground style of the image.
            Text(item.title) // Display the title of the 'item'.
            Spacer()
        }
    }
}

#Preview {
    CityRowView(item: ItemModel(id: "12", title: "Title", isComplated: true))
}
