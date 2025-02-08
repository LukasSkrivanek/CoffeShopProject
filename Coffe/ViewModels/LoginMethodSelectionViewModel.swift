//
//  LoginMethodSelectionViewModel.swift
//  Coffe
//
//  Created by macbook on 07.02.2025.
//
import SwiftUI

@Observable
class LoginMethodSelectionViewModel {

   var selectedMethod: LoginMethod? = nil
    
    // Funkce pro změnu metody přihlášení
    func selectMethod(_ method: LoginMethod) {
        selectedMethod = method
    }
}
