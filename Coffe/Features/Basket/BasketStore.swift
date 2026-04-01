//
//  BasketStore.swift
//  Coffe
//

import Foundation
import Dependencies

@Observable
final class BasketStore {
    private(set) var items: [Drink] = []

    func add(_ drink: Drink) {
        items.append(drink)
    }

    func remove(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
}

extension BasketStore: DependencyKey {
    static let liveValue = BasketStore()
}

extension DependencyValues {
    var basketStore: BasketStore {
        get { self[BasketStore.self] }
        set { self[BasketStore.self] = newValue }
    }
}
