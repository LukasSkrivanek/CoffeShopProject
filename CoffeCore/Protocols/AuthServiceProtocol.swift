//
//  AuthServiceProtocol.swift
//  CoffeCore
//

import Foundation

public protocol AuthServiceProtocol: Sendable {
    func createUser(email: String, password: String) async throws -> AuthDataResultModel
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel
    func getAuthenticatedUser() throws -> AuthDataResultModel?
    func resetPassword(email: String) async throws
    func updatePassword(password: String) async throws
    func updateEmail(email: String) async throws
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel
    func signOut() throws
}
