//
//  BasketViewModel.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import Foundation
import Firebase
import SwiftUI
import Dependencies

@Observable
final class BasketViewModel {
    var basketError: AppError?
    var showAlert: AnyAppAlert?
    var showError = false

    private let store: BasketStore

    init(store: BasketStore) {
        self.store = store
    }

    var items: [Drink] { store.items }
    var totalPrice: Double { store.totalPrice }

    func deleteItems(at offsets: IndexSet) {
        store.remove(at: offsets)
    }

    func createOrder() {
        @Dependency(\.userRepository) var userRepository
        @Dependency(\.firebaseRepository) var firebaseRepository

        guard !store.items.isEmpty else {
            handleError(.emptyBasketError)
            return
        }
        guard let user = userRepository.user else {
            handleError(.noUserError)
            return
        }
        guard Auth.auth().currentUser != nil else {
            handleError(.noUserError)
            return
        }
        let order = Order(
            id: UUID().uuidString,
            customerName: user.name,
            customerAdress: user.address,
            customerMobile: user.mobile,
            items: store.items,
            orderTotal: store.totalPrice
        )
        Task {
            await firebaseRepository.placeOrder(order: order)
        }
        store.remove(at: IndexSet(store.items.indices))
    }
}

extension BasketViewModel: ComposableDependency {
    convenience init() {
        @Dependency(\.basketStore) var store
        self.init(store: store)
    }
}

private extension BasketViewModel {
    func handleError(_ error: AppError) {
        basketError = error
        showAlert = AnyAppAlert(
            title: "Error",
            subtitle: error.description,
            buttons: { AnyView(Button("OK") { self.showError = false }) }
        )
        showError = true
    }
}
