//
//  MockData.swift
//  Coffe
//
//  Created by macbook on 21.03.2025.
//

import Foundation
@testable import Coffe

class MockData {
    static let drinkDummyData = Drink(
        name: "Coffe",
        description: "Desc",
        imageLink: "image",
        price: 2.0,
        category: .hot
    )
    static let orderDummyData =  Order(
        id: UUID().uuidString,
        customerName: "Custom",
        customerAdress: "Adress",
        customerMobile: "f73343",
        items: [Drink(
            name: "Coffe",
            description: "Late",
            imageLink: "image",
            price: 2.0,
            category: .cold
        )],
        orderTotal: 2)
}
