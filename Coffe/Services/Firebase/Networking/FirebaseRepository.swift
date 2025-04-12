//
//  FirebaseRepository.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//
import Foundation

protocol FirebaseRepositoryProtocol: DataSource {
    func fetchDrinks() async throws -> [Drink]
    func saveDrinks()
    func placeOrder(order: Order)
}

class FirebaseRepository: FirebaseRepositoryProtocol {}

// MARK: - Fetching Drinks
extension FirebaseRepository {
    func fetchDrinks() async throws -> [Drink] {
        try await withCheckedThrowingContinuation { continuation in
            firebaseReference(.drinks).getDocuments { querySnapshot, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    print("⚠️ Dokumenty nebyly nalezeny, vracím prázdné pole")
                    continuation.resume(returning: [])
                    return
                }
                print("✅ Načteno \(documents.count) dokumentů")
                let result = documents.compactMap { queryDocumentSnapshot -> Drink? in
                    return try? queryDocumentSnapshot.data(as: Drink.self)
                }
                continuation.resume(returning: result)
            }
        }
    }
}

// MARK: - Saving Drinks
extension FirebaseRepository {
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

// MARK: - Placing Orders
extension FirebaseRepository {
    func placeOrder(order: Order) {
        do {
            try firebaseReference(FCollectionReference.orders).document(order.id).setData(from: order.self)
        } catch {
            print("Error saving order to Firebase,", error.localizedDescription)
        }
    }
}
