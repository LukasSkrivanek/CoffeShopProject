//
//  FirebaseAuthServiceAdapter.swift
//  Coffe
//
//  Created by macbook on 10.02.2025.
//

import Swift
import FirebaseAuth

protocol AuthServiceProtocol {
    func createUser(email: String, password: String) async throws -> AuthDataResultModel
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel
    func getAuthenticatedUser() throws -> AuthDataResultModel
    func resetPassword(email: String) async throws
    func updatePassword(password: String) async throws
    func updateEmail(email: String) async throws
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel
    func signOut() throws
}

final class FirebaseAuthServiceAdapter: AuthServiceProtocol {
    func signOut() throws {
        try Auth.auth().signOut()
    }
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: FirebaseAuthUserAdapter(user: authDataResult.user))
    }
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: FirebaseAuthUserAdapter(user: authDataResult.user))
    }
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: FirebaseAuthUserAdapter(user: user))
    }

    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }

    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else { throw URLError(.badServerResponse) }
        try await user.updatePassword(to: password)
    }

    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else { throw URLError(.badServerResponse) }
        try await user.sendEmailVerification(beforeUpdatingEmail: email)
    }

    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: FirebaseAuthUserAdapter(user: authDataResult.user))
    }
}
