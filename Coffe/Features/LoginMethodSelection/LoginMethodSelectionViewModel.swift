//
//  LoginMethodSelectionViewModel.swift
//  Coffe
//
//  Created by macbook on 07.02.2025.
//
import SwiftUI
import Dependencies

@Observable
class LoginMethodSelectionViewModel {
    @ObservationIgnored
    @Dependency(\.userRepository)
    private var userRepository

    @ObservationIgnored
    @Dependency(\.authenticationManager)
    private var authenticationManager

    var selectedMethod: LoginMethod?

    func selectMethod(_ method: LoginMethod) {
        selectedMethod = method
    }

    func signInGoogle() async throws {
        let tokens = try await SignInGoogleHelper().signIn()
        try await authenticationManager.signInWithGoogle(tokens: tokens)
    }
}
