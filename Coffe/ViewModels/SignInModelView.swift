//
//  SignInModelView.swift
//  Coffe
//
//  Created by macbook on 09.03.2024.
//
import Foundation
import Observation

@Observable
final class SignInEmailViewModel {
    var authenticationManager: AuthenticationManager
    
    var email = ""
    var password = ""
    var isUserLoggedIn = true
    
    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
    }

    
    func signUp() async throws{
        guard !email.isEmpty, !password.isEmpty else {return}
        try await authenticationManager.createUser(email: email, password: password)
    }
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else {return}
        try await authenticationManager.signInUser(email: email, password: password)
    }
}
