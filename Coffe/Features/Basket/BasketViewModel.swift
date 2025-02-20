//
//  BasketViewModel.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import Foundation
import Firebase
import SwiftUI

@Observable
final class BasketViewModel: Sendable {
    var firebaseRepository: FirebaseRepository
    var userRepository: UserRepository
    private(set) var items: [Drink] = []
    var basketError: AppError?
    var showAlert: AnyAppAlert?
    var showError = false
    init(userRepository: UserRepository, firebaseRepository: FirebaseRepository) {
        self.firebaseRepository = firebaseRepository
        self.userRepository = userRepository
    }
    func add(drink: Drink) {
        items.append(drink)
        print("\(items.count)")
    }
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    func createOrder() {
        guard !items.isEmpty else {
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
            items: items,
            orderTotal: totalPrice
        )
        Task {
            await firebaseRepository.placeOrder(order: order)
        }
        items = []
    }
    func showPlaceOrderAlert() {
        showAlert = AnyAppAlert(
            title: "Create Order?",
            subtitle: "Do you want to create an order for this basket?",
            buttons: {
                AnyView(Button("Create") {
                    self.createOrder()
                })
            }
        )
    }
    private func handleError(_ error: AppError) {
        basketError = error
        showAlert = AnyAppAlert(
            title: "Error",
            subtitle: error.description,
            buttons: {
                AnyView(Button("OK") { self.showError = false })
            }
        )
        showError = true
    }
}
