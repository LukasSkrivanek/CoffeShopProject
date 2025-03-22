//
//  FirebaseRepositoryMock.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import XCTest
@testable import Coffe

class FirebaseRepositoryMock: FirebaseRepositoryProtocol {
    var fetchDrinksResult: Result<[Drink], Error> = .success([])
    var saveDrinksCalled = false
    var placeOrderCalled = false
    var placedOrder: Order?

    func fetchDrinks() async throws -> [Drink] {
        switch fetchDrinksResult {
        case .success(let drinks):
            return drinks
        case .failure(let error):
            throw error
        }
    }

    func saveDrinks() {
        saveDrinksCalled = true
    }

    func placeOrder(order: Order) {
        placeOrderCalled = true
        placedOrder = order
    }
}
