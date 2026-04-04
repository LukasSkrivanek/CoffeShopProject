//
//  FirebaseRepository.swift
//  Coffe
//

import Foundation
import CoffeCore

actor FirebaseRepository: DrinkRepositoryProtocol {
    func fetchDrinks() async throws -> [Drink] {
        try await withCheckedThrowingContinuation { continuation in
            firebaseReference(.drinks).getDocuments { querySnapshot, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                let result = (querySnapshot?.documents ?? []).compactMap {
                    try? $0.data(as: Drink.self)
                }
                continuation.resume(returning: result)
            }
        }
    }

    func placeOrder(order: Order) async throws {
        try firebaseReference(FCollectionReference.orders).document(order.id).setData(from: order)
    }

    func saveDrinks() {
        for drink in DummyData.drinks {
            do {
                try firebaseReference(FCollectionReference.drinks).document(drink.id).setData(from: drink.self)
            } catch {
                print("Error saving drink to Firebase")
            }
        }
    }
}
