//
//  BasketViewModel.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import Foundation
import Firebase

@Observable
final class BasketViewModel {
    private let firebaseRepository = FirebaseRepository()
    private(set) var items: [Drink] = []
    
    var basketError: AppError?
    var showAlert: AnyAppAlert?
    var showError = false
    
    func add(drink: Drink) {
        items.append(drink)
        print("\(items.count)")
    }
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    var totalprice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    func createOrder(for user: UserModel?) {
        guard !items.isEmpty else {
            setError(.emptyBasketError)
            return
        }
        guard let user = user else {
            setError(.noUserError)
            return
        }
        guard Auth.auth().currentUser != nil else {
            setError(.noUserError)
            return
        }
        let order = Order(
            id: UUID().uuidString,
            customerName: user.name,
            customerAdress: user.address,
            customerMobile: user.mobile,
            items: items,
            orderTotal: totalprice
        )
        Task {
            await firebaseRepository.placeOrder(order: order)
        }
        items = []
    }
    private func setError(_ error: AppError) {
        basketError = error
        showError = true
    }
}
