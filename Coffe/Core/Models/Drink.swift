//
//  Drink.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import Foundation

enum Category: String, Codable, Hashable {
    case hot, cold, softDrinks
}
struct Drink: Codable, Hashable {
    var id: String = UUID().uuidString
    let name: String
    let description: String
    let imageLink: String
    let price: Double
    let category: Category
    var imageURL: URL? {
        URL(string: imageLink)
    }
}
