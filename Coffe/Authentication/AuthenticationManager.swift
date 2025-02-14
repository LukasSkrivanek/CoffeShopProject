//
//  AuthenticationManager.swift
//  Coffe
//
//  Created by macbook on 09.03.2024.
//

import Foundation
import FirebaseAuth

final class AuthenticationManager {
    
    private var authServiceProtocol: AuthServiceProtocol

    init(authServiceProtocol: AuthServiceProtocol) {
        self.authServiceProtocol = authServiceProtocol
    }
}


extension AuthenticationManager {
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        return try await authServiceProtocol.createUser(email: email, password: password)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        return try await authServiceProtocol.signInUser(email: email, password: password)
    }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel? {
        return try authServiceProtocol.getAuthenticatedUser()
    }
    
    func resetPassword(email: String) async throws {
        try await authServiceProtocol.resetPassword(email: email)
    }
    
    func updatePassword(password: String) async throws {
        try await authServiceProtocol.updatePassword(password: password)
    }
    
    func updateEmail(email: String) async throws {
        try await authServiceProtocol.updateEmail(email: email)
    }
    
    func signOut() throws { 
           try authServiceProtocol.signOut()
       }
}

extension AuthenticationManager {
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        return try await authServiceProtocol.signInWithGoogle(tokens: tokens)
    }
}
