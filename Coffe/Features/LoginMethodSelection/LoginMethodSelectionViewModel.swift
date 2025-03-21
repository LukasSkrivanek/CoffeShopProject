//
//  LoginMethodSelectionViewModel.swift
//  Coffe
//
//  Created by macbook on 07.02.2025.
//
import SwiftUI

@Observable
class LoginMethodSelectionViewModel {
    var userRepository: UserRepositoryProtocol
    var authenticationManager: AuthServiceProtocol!
    var selectedMethod: LoginMethod?
    init(userRepository: UserRepositoryProtocol, authenticationManager: AuthServiceProtocol) {
        self.userRepository = userRepository
        self.authenticationManager = authenticationManager
    }
    func selectMethod(_ method: LoginMethod) {
        selectedMethod = method
    }
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper(userRepository: userRepository)
            let tokens = try await helper.signIn()
        try await authenticationManager.signInWithGoogle(tokens: tokens)
        }
}
