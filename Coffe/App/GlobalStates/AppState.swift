//
//  AppState.swift
//  Coffe
//
//  Created by macbook on 08.02.2025.
//

import SwiftUI

@MainActor
@Observable
final class AppState {
    var isSignedIn: Bool {
        didSet { UserDefaults.standard.set(isSignedIn, forKey: "isSignedIn") }
    }

    init() {
        self.isSignedIn = UserDefaults.standard.bool(forKey: "isSignedIn")
    }
}

@Observable
final class BasketState {
    var items: [Drink] = []

    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }

    func add(_ drink: Drink) {
        items.append(drink)
    }

    func remove(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
