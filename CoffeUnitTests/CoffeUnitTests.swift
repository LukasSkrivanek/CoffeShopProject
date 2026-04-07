//
//  CoffeUnitTests.swift
//  CoffeUnitTests
//
//  Created by Skrivanek, Lukas on 02.04.2026.
//

import Testing
import Foundation
import DependenciesTestSupport
@testable @preconcurrency import CoffeCore

// MARK: - Helpers

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

// MARK: - BasketViewModel Tests

@Suite("BasketViewModel", .dependencies)
struct BasketViewModelTests {

    @Test("createOrder with empty basket sets emptyBasketError alert")
    func createOrder_emptyBasket_setsAlert() {
        let viewModel = BasketViewModel()
        let basket = BasketState()

        viewModel.createOrder(from: basket)

        #expect(viewModel.alert == .error(.emptyBasketError))
    }

    @Test(
        "createOrder with no user sets noUserError alert",
        .dependency(\.sessionValidator, StubSessionValidator(isAuthenticated: true))
    )
    func createOrder_noUser_setsAlert() {
        let viewModel = BasketViewModel()
        let basket = BasketState()
        basket.add(.stub())

        viewModel.createOrder(from: basket)

        #expect(viewModel.alert == .error(.noUserError))
    }

    @Test(
        "createOrder when not authenticated sets noUserError alert",
        .dependencies {
            $0.userRepository = UserRepository(user: .stub(), secureStorage: EmptySecureStorage())
            $0.sessionValidator = StubSessionValidator(isAuthenticated: false)
        }
    )
    func createOrder_notAuthenticated_setsAlert() {
        let viewModel = BasketViewModel()
        let basket = BasketState()
        basket.add(.stub())

        viewModel.createOrder(from: basket)

        #expect(viewModel.alert == .error(.noUserError))
    }

    @Test(
        "createOrder with valid state clears basket items",
        .dependencies {
            $0.userRepository = UserRepository(user: .stub(), secureStorage: EmptySecureStorage())
            $0.sessionValidator = StubSessionValidator(isAuthenticated: true)
            $0.drinkRepository = StubDrinkRepository()
        }
    )
    func createOrder_validState_clearsBasket() {
        let viewModel = BasketViewModel()
        let basket = BasketState()
        basket.add(.stub(name: "Latte", price: 4.0))

        viewModel.createOrder(from: basket)
        #expect(basket.items.isEmpty)
        #expect(viewModel.alert == nil)
    }
}
