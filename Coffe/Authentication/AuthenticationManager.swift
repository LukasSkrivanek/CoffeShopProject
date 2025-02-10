//
//  AuthenticationManager.swift
//  Coffe
//
//  Created by macbook on 09.03.2024.
//

import Foundation
import FirebaseAuth

struct AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private var authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol = FirebaseAuthServiceAdapter()) {
        self.authService = authService
    }
}


extension AuthenticationManager {
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        return try await authService.createUser(email: email, password: password)
    }

    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        return try await authService.signInUser(email: email, password: password)
    }

    func getAuthenticatedUser() throws -> AuthDataResultModel? {
        return try authService.getAuthenticatedUser()
    }

    func resetPassword(email: String) async throws {
        try await authService.resetPassword(email: email)
    }

    func updatePassword(password: String) async throws {
        try await authService.updatePassword(password: password)
    }

    func updateEmail(email: String) async throws {
        try await authService.updateEmail(email: email)
    }
}

extension AuthenticationManager {
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        return try await authService.signInWithGoogle(tokens: tokens)
    }
}
