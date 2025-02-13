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
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func loginUser() async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password cannot be empty"
            return
        }

        do {
            let authUser = try await AuthenticationManager.shared.signInUser(email: email, password: password)
            let userModel = UserModel(id: authUser.user.uid, name: "Lukas", email: authUser.user.email ?? "", address: "", mobile: "")

            await MainActor.run {
                userRepository.user = userModel
            
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
            }
        }
    }
}
