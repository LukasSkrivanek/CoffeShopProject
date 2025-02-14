//
//  LoginMethodSelectionViewModel.swift
//  Coffe
//
//  Created by macbook on 07.02.2025.
//
import SwiftUI

@Observable
class LoginMethodSelectionViewModel {
    var userRepository: UserRepository
    var authenticationManager: AuthenticationManager!
    
    var selectedMethod: LoginMethod? = nil
    
    init(userRepository: UserRepository, authenticationManager: AuthenticationManager!) {
        self.userRepository = userRepository
        self.authenticationManager = authenticationManager
    }
    
    func selectMethod(_ method: LoginMethod) {
        selectedMethod = method
    }
    
    func signInGoogle() async throws{
        let helper = SignInGoogleHelper(userRepository: userRepository)
            let tokens = try await helper.signIn()
        try await authenticationManager.signInWithGoogle(tokens: tokens)
            
        }

}
