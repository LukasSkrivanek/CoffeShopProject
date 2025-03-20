//
//  MockAuthService.swift
//  Coffe
//
//  Created by macbook on 20.03.2025.
//
import Foundation
@testable import Coffe

struct MockAuthUser: AuthUserProtocol {
    var uid: String
    var email: String?
}

class MockAuthService: AuthServiceProtocol {

    private let mockUser = AuthDataResultModel(
        user: MockAuthUser(uid: "123", email: "test@example.com")
    )

    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        return mockUser
    }

    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        return mockUser
    }

    func getAuthenticatedUser() throws -> AuthDataResultModel {
        return mockUser
    }

    func resetPassword(email: String) async throws {

    }

    func updatePassword(password: String) async throws {

    }

    func updateEmail(email: String) async throws {

    }

    func signOut() throws {

    }

    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        return mockUser
    }
}
