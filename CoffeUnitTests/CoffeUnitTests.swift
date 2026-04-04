//
//  CoffeUnitTests.swift
//  CoffeUnitTests
//
//  Created by Skrivanek, Lukas on 02.04.2026.
//

import Testing
import Foundation
import Dependencies
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

struct StubUserSecureStorage: SecureStorageProtocol {
    private let userData: Data?
    init(user: UserModel) { userData = try? JSONEncoder().encode(user) }
    func save(data: Data, with key: String) async {}
    func get(with key: String) async -> Data? { userData }
    func delete(with key: String) async {}
}

struct StubDrinkRepository: DrinkRepositoryProtocol {
    var fetchDrinksResult: [Drink] = []
    var placeOrderCalled = false

    func fetchDrinks() async throws -> [Drink] { fetchDrinksResult }
    func placeOrder(order: Order) async throws {}
}

// MARK: - BasketViewModel Tests

@Suite("BasketViewModel")
struct BasketViewModelTests {

    @Test("createOrder with empty basket sets emptyBasketError alert")
    func createOrder_emptyBasket_setsAlert() {
        withDependencies {
            $0.userRepository = UserRepository(secureStorage: EmptySecureStorage())
        } operation: {
            let viewModel = BasketViewModel()
            let basket = BasketState()

            viewModel.createOrder(from: basket)

            #expect(viewModel.alert == .error(.emptyBasketError))
        }
    }

    @Test("createOrder with no user sets noUserError alert")
    func createOrder_noUser_setsAlert() {
        withDependencies {
            let repo = UserRepository(secureStorage: EmptySecureStorage())
            repo.user = nil
            $0.userRepository = repo
            $0.sessionValidator = StubSessionValidator(isAuthenticated: true)
        } operation: {
            let viewModel = BasketViewModel()
            let basket = BasketState()
            basket.add(.stub())

            viewModel.createOrder(from: basket)

            #expect(viewModel.alert == .error(.noUserError))
        }
    }

    @Test("createOrder when not authenticated sets noUserError alert")
    func createOrder_notAuthenticated_setsAlert() {
        withDependencies {
            let repo = UserRepository(secureStorage: EmptySecureStorage())
            repo.user = .stub()
            $0.userRepository = repo
            $0.sessionValidator = StubSessionValidator(isAuthenticated: false)
        } operation: {
            let viewModel = BasketViewModel()
            let basket = BasketState()
            basket.add(.stub())

            viewModel.createOrder(from: basket)

            #expect(viewModel.alert == .error(.noUserError))
        }
    }

    @Test("createOrder with valid state clears basket items")
    func createOrder_validState_clearsBasket() async {
        let repo = UserRepository(secureStorage: StubUserSecureStorage(user: .stub()))

        withDependencies {
            $0.userRepository = repo
            $0.sessionValidator = StubSessionValidator(isAuthenticated: true)
            $0.drinkRepository = StubDrinkRepository()
        } operation: {
            let viewModel = BasketViewModel()
            let basket = BasketState()
            basket.add(.stub())
            basket.add(.stub(name: "Latte", price: 4.0))

            viewModel.createOrder(from: basket)

            #expect(basket.items.isEmpty)
            #expect(viewModel.alert == nil)
        }
    }
}
