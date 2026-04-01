//
//  RegistrationViewModel.swift
//  Coffe
//
//  Created by macbook on 08.02.2025.
//
import Foundation
import Dependencies

@Observable
class RegistrationViewModel {
    private var userRepository: UserRepository
    var authenticationManager: AuthenticationManager
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var alert: AnyAppAlert?
    init(userRepository: UserRepository, authenticationManager: AuthenticationManager) {
        self.userRepository = userRepository
        self.authenticationManager = authenticationManager
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
            try await authenticationManager.createUser(email: email, password: password)
            userRepository.user = await userRepository.fetchUser()
        } catch {
            await MainActor.run {
                alert = AnyAppAlert(error: error)
            }
        }
    }
}

extension RegistrationViewModel: ComposableDependency {
    convenience init() {
        @Dependency(\.userRepository) var userRepository
        @Dependency(\.authenticationManager) var authenticationManager
        self.init(userRepository: userRepository, authenticationManager: authenticationManager)
    }
}
