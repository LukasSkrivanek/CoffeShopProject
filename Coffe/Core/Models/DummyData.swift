//
//  DummyData.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import Foundation

struct DummyData {
    static let basket = Basket(id: UUID().uuidString, items: [])
    static let user = UserModel(
        id: UUID().uuidString,
        name: "Lukas",
        email: "ksdjsld",
        address: "",
        mobile: "73517272727"
    )
    static let drinks: [Drink] = [
        Drink(
            id: UUID().uuidString,
            name: "Latte",
            description: """
            Latte combines espresso with steamed milk and a light layer of foam.
            It's a creamy coffee classic, perfect for those who love a smoother coffee experience.
            """,
            imageLink: "https://short.url/latte.jpg",
            price: 3.00,
            category: Category.hot
        ),
        Drink(
            id: UUID().uuidString,
            name: "Iced Coffee",
            description: """
            Iced Coffee is a refreshing cold coffee drink, made by brewing hot coffee,
            then cooling it down with ice. It's a perfect pick-me-up for warm days.
            """,
            imageLink: "https://short.url/icedcoffee.jpg",
            price: 2.75,
            category: Category.cold
        ),
        Drink(
            id: UUID().uuidString,
            name: "Lemonade",
            description: """
            Lemonade is a classic soft drink made from lemon juice, water, and sugar.
            It's a refreshing choice for a hot day, offering a perfect balance of sweet and tart.
            """,
            imageLink: "https://short.url/lemonade.jpg",
            price: 2.00,
            category: Category.softDrinks
        ),
        Drink(
            id: UUID().uuidString,
            name: "Cappuccino",
            description: """
            Cappuccino is an Italian coffee drink that is traditionally prepared
            with equal parts double espresso, steamed milk, and steamed milk foam on top.
            It offers a rich and bold flavor.
            """,
            imageLink: "https://short.url/cappuccino.jpg",
            price: 3.25,
            category: Category.hot
        ),
        Drink(
            id: UUID().uuidString,
            name: "Cold Brew",
            description: """
            Cold Brew coffee is made by steeping coarse coffee grounds in cold water for an extended period.
            It's known for its smooth, mild flavor and lack of acidity.
            """,
            imageLink: "https://short.url/coldbrew.jpg",
            price: 3.50,
            category: Category.cold
        ),
        Drink(
            id: UUID().uuidString,
            name: "Sparkling Water",
            description: """
            Sparkling water is water that has been infused with carbon dioxide gas under pressure,
            creating a bubbly drink. It's a simple, hydrating option with a refreshing fizz.
            """,
            imageLink: "https://short.url/sparkling.jpg",
            price: 1.50,
            category: Category.softDrinks
        )
    ]
}
