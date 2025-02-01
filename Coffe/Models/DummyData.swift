//
//  DummyData.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import Foundation


struct DummyData {
    static let basket = Basket(id: UUID().uuidString, items: [])
    static let user = UserModel(id: UUID().uuidString, name: "Lukas", email: "ksdjsld", address: "", mobile: "73517272727")
    static let drinks: [Drink] = [
        Drink(id: UUID().uuidString, name: "Latte", description: "Latte combines espresso with steamed milk and a light layer of foam. It's a creamy coffee classic, perfect for those who love a smoother coffee experience.", imageLink: "https://pixabay.com/get/g9eb1b22c70cc85ccf95220ec28796c0498aa103999bb980baa4074a2d99249e26bd562e0a2b0a8713991ee6b36f63136a9bff441477756b3c510b5af82fdfe45_1280.jpg", price: 3.00, category: Category.hot),
        Drink(id: UUID().uuidString, name: "Iced Coffee", description: "Iced Coffee is a refreshing cold coffee drink, made by brewing hot coffee, then cooling it down with ice. It's a perfect pick-me-up for warm days.", imageLink: "https://pixabay.com/get/gd814e054105de4c34faadde9f23c8f6b214da7d47ae2a79f90e6be09167c614c950b9684dd0c9b32c435390c792406b4e4abc99a5faa1ad3198cdb2e580c432c_1280.jpg", price: 2.75, category: Category.cold),
        Drink(id: UUID().uuidString, name: "Lemonade", description: "Lemonade is a classic soft drink made from lemon juice, water, and sugar. It's a refreshing choice for a hot day, offering a perfect balance of sweet and tart.", imageLink: "https://pixabay.com/get/g2101b8248b8fa3d5751a82300e091d0bb8a8a6dbf86751936625febb674b7f214fabe62cdd63ade2185ddde9b5b4ae04a6dc0d48a1aeb07ad63f2ba2c3eaf4be_1280.jpg", price: 2.00, category: Category.softDrinks),
        Drink(id: UUID().uuidString, name: "Cappuccino", description: "Cappuccino is an Italian coffee drink that is traditionally prepared with equal parts double espresso, steamed milk, and steamed milk foam on top. It offers a rich and bold flavor.", imageLink: "https://pixabay.com/get/gb6254128820a104eebb0e7ce7e0ad1bea5d0ec1c4bedbef9e6fbf446ea609cf8bf8e0556cf69a85892037d908c68a269_1280.jpg", price: 3.25, category: Category.hot),
        Drink(id: UUID().uuidString, name: "Cold Brew", description: "Cold Brew coffee is made by steeping coarse coffee grounds in cold water for an extended period. It's known for its smooth, mild flavor and lack of acidity.", imageLink: "https://cdn.pixabay.com/photo/2017/08/07/01/41/cold-brew-coffee-2599243_960_720.jpg", price: 3.50, category: Category.cold),
        Drink(id: UUID().uuidString, name: "Sparkling Water", description: "Sparkling water is water that has been infused with carbon dioxide gas under pressure, creating a bubbly drink. It's a simple, hydrating option with a refreshing fizz.", imageLink: "https://pixabay.com/get/g691bc00469d844eddff1b3c5c9be178cdab6a5875b29a01fa0d9878fc3df35b60c931712bc510829ab59083d25d4c6d881ad5f4c03d0dbf92ac097b3666f0226_1280.jpg", price: 1.50, category: Category.softDrinks)
    ]

}
