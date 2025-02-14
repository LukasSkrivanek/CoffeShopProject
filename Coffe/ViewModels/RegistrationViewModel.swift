//
//  RegistrationViewModel.swift
//  Coffe
//
//  Created by macbook on 08.02.2025.
//
import Foundation

@Observable
class RegistrationViewModel {
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var alert: AnyAppAlert?  

    private var userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func registerUser() async {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            await MainActor.run {
                alert = AnyAppAlert(title: "Error", subtitle: "All fields are required")
            }
            return
        }

        guard password == confirmPassword else {
            await MainActor.run {
                alert = AnyAppAlert(title: "Error", subtitle: "Passwords do not match")
            }
            return
        }

        do {
            try await AuthenticationManager.shared.createUser(email: email, password: password)
            userRepository.user = await userRepository.fetchUser()
        } catch {
            await MainActor.run {
                alert = AnyAppAlert(error: error)
            }
        }
    }
}
