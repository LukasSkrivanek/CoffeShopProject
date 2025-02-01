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
    var showError = false
    
    // Přidání drinku do košíku
    func add(drink: Drink) {
        items.append(drink)
        print("\(items.count)")
    }
    
    // Smazání položek
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    // Výpočet celkové ceny
    var totalprice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    // Vytvoření objednávky
    func createOrder(for user: UserModel?) {
        // Zkontrolovat, zda je košík prázdný
        guard !items.isEmpty else {
            setError(.emptyBasketError)
            return
        }
        
        // Zkontrolovat, zda je uživatel platný
        guard let user = user else {
            setError(.noUserError)
            return
        }

        // Zkontrolovat, zda je uživatel přihlášen
        guard Auth.auth().currentUser != nil else {
            setError(.noUserError)
            return
        }
        
        // Vytvořit objednávku
        let order = Order(
            id: UUID().uuidString,
            customerName: user.name,
            customerAdress: user.address,
            customerMobile: user.mobile,
            items: items,
            orderTotal: totalprice
        )
        
        // Odeslání objednávky do Firebase
        firebaseRepository.placeOrder(order: order)
        
        // Vyprázdnit košík
        items = []
    }
    
    // Pomocná metoda pro nastavení chyby
    private func setError(_ error: AppError) {
        basketError = error
        showError = true
    }
}
