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
    var userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func selectMethod(_ method: LoginMethod) {
        selectedMethod = method
    }
    
    func signInGoogle() async throws{
            let helper = SignInGoogleHelper()
            let tokens = try await helper.signIn()
            try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
            
        }

}
