//
//  AuthenticationManager.swift
//  Coffe
//
//  Created by macbook on 09.03.2024.
//

import Foundation
import Dependencies

final class AuthenticationManager {
    @Dependency(\.firebaseAuthServiceAdapter) private var authServiceProtocol 
}

extension AuthenticationManager {
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        return try await authServiceProtocol.createUser(email: email, password: password)
    }
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

extension AuthenticationManager: ComposableDependency {}

extension AuthenticationManager {
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        return try await authServiceProtocol.signInWithGoogle(tokens: tokens)
    }
}
