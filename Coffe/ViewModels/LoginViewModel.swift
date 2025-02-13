//
//  LoginViewModel.swift
//  Coffe
//
//  Created by macbook on 13.02.2025.
//
import SwiftUI

@Observable
class LoginViewModel {
    var userRepository: UserRepository
    var email: String = ""
    var password: String = ""
    var errorMessage: String?
    var alert: AnyAppAlert? // Alert, který bude zobrazen

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    /// Pokusí se přihlásit uživatele a vrátí `true`, pokud bylo přihlášení úspěšné.
    func loginUser() async -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            await MainActor.run {
                alert = AnyAppAlert(title: "Error", subtitle: "Email and password cannot be empty")
            }
            return false
        }

        do {
            let authUser = try await AuthenticationManager.shared.signInUser(email: email, password: password)
            let userModel = UserModel(id: authUser.user.uid, name: "Lukas", email: authUser.user.email ?? "", address: "", mobile: "")

            await MainActor.run {
                userRepository.user = userModel
            }

            return true
        } catch {
            await MainActor.run {
                alert = AnyAppAlert(error: error) // Nastavení alertu
            }
            return false
        }
    }
}

