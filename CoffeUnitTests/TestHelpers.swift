//
//  TestHelpers.swift
//  CoffeUnitTests
//

import Foundation
@testable @preconcurrency import CoffeCore

extension Drink {
    static func stub(name: String = "Espresso", price: Double = 3.5) -> Drink {
        Drink(name: name, description: "", imageLink: "", price: price, category: .hot)
    }
}

extension UserModel {
    static func stub() -> UserModel {
        UserModel(id: "1", name: "John", email: "john@test.com", address: "Main St", mobile: "123")
    }
}

struct StubSessionValidator: SessionValidating {
    var isAuthenticated: Bool
}

actor StubDrinkRepository: DrinkRepositoryProtocol {
    var fetchDrinksResult: [Drink] = []
    var placeOrderCalled = false

    func fetchDrinks() async throws -> [Drink] { fetchDrinksResult }
    func placeOrder(order: Order) async throws { placeOrderCalled = true }
}
