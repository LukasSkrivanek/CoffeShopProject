//
//  BasketState.swift
//  CoffeCore
//

import Foundation
import Observation

@Observable
public final class BasketState {
    public var items: [Drink] = []

    public var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }

    public init() {}

    public func add(_ drink: Drink) {
        items.append(drink)
    }

    public func remove(at offsets: IndexSet) {
        for index in offsets.sorted(by: >) {
            items.remove(at: index)
        }
    }
}
