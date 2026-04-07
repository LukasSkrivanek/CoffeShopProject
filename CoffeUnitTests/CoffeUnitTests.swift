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
