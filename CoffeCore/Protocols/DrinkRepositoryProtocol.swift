//
//  DrinkRepositoryProtocol.swift
//  CoffeCore
//

import Foundation

public protocol DrinkRepositoryProtocol: Sendable {
    func fetchDrinks() async throws -> [Drink]
    func placeOrder(order: Order) async throws
}
