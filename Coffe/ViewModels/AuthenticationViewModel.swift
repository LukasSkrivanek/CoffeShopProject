//
//  AuthenticationViewModel.swift
//  Coffe
//
//  Created by macbook on 10.03.2024.
//

import Foundation


@MainActor
@Observable
final class AuthenticationViewModel{
    func signInGoogle() async throws{
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        
    }
}
