//
//  Drink.swift
//  CoffeCore
//

import Foundation

public enum Category: String, Codable, Hashable {
    case hot, cold, softDrinks
}

public struct Drink: Codable, Hashable {
    public var id: String = UUID().uuidString
    public let name: String
    public let description: String
    public let imageLink: String
    public let price: Double
    public let category: Category

    public var imageURL: URL? {
        URL(string: imageLink)
    }

    public init(id: String = UUID().uuidString, name: String, description: String, imageLink: String, price: Double, category: Category) {
        self.id = id
        self.name = name
        self.description = description
        self.imageLink = imageLink
        self.price = price
        self.category = category
    }
}
