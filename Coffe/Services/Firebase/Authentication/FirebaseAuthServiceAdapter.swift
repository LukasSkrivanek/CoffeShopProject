//
//  FirebaseAuthServiceAdapter.swift
//  Coffe
//

import FirebaseAuth
import CoffeCore

final class FirebaseAuthServiceAdapter: AuthServiceProtocol {
    func signOut() throws {
        try Auth.auth().signOut()
    }

    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: FirebaseAuthUserAdapter(user: result.user))
    }

    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: FirebaseAuthUserAdapter(user: result.user))
    }

    func getAuthenticatedUser() throws -> AuthDataResultModel? {
        guard let user = Auth.auth().currentUser else { return nil }
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
        let result = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: FirebaseAuthUserAdapter(user: result.user))
    }
}
