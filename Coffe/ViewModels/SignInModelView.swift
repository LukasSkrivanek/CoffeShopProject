//
//  SignInModelView.swift
//  Coffe
//
//  Created by macbook on 09.03.2024.
//
import Foundation
import Observation

@Observable
@MainActor
final class SignInEmailViewModel {
    var email = ""
    var password = ""
    var isUserLoggedIn = true
    
    func signUp() async throws{
        guard !email.isEmpty, !password.isEmpty else {return}
        
    
        _ = try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else {return}
        
    
        _ = try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}
