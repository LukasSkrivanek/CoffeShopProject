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
    var authenticationManager: AuthenticationManager
    var email: String = ""
    var password: String = ""
    var alert: AnyAppAlert?
    init(userRepository: UserRepository, authenticationManager: AuthenticationManager ) {
        self.userRepository = userRepository
        self.authenticationManager = authenticationManager
    }
    func loginUser() async -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            await MainActor.run {
                alert = AnyAppAlert(title: "Error", subtitle: "Email and password cannot be empty")
            }
            return false
        }
        do {
            let authUser = try await authenticationManager.signInUser(email: email, password: password)
            let userModel = UserModel(id: authUser.user.uid, name: "Lukas", email: authUser.user.email ?? "", address: "", mobile: "")

            await MainActor.run {
                userRepository.user = userModel
            }
            return true
        } catch {
            await MainActor.run {
                alert = AnyAppAlert(error: error)
            }
            return false
        }
    }
}
