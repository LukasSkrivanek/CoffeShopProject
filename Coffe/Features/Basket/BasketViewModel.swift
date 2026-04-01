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

    @ObservationIgnored
    @Dependency(\.userRepository)
    private var userRepository

    @ObservationIgnored
    @Dependency(\.firebaseRepository)
    private var firebaseRepository

    var basketError: AppError?
    var showAlert: AnyAppAlert?
    var showError = false

    func createOrder(from basketState: BasketState) {
        guard !basketState.items.isEmpty else {
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
            items: basketState.items,
            orderTotal: basketState.totalPrice
        )
        Task {
            await firebaseRepository.placeOrder(order: order)
        }
        basketState.items = []
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
