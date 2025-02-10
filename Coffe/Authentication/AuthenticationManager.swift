//
//  AuthenticationManager.swift
//  Coffe
//
//  Created by macbook on 09.03.2024.
//

import Foundation
import FirebaseAuth

struct FirebaseAuthUserAdapter: AuthUserProtocol {
    private let user: FirebaseAuth.User

    init(user: FirebaseAuth.User) {
        self.user = user
    }

    var uid: String {
        user.uid
    }

    var email: String? {
        user.email
    }
}


struct AuthenticationManager {
    static let shared = AuthenticationManager()
}


extension AuthenticationManager{
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: FirebaseAuthUserAdapter(user: authDataResult.user))
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: FirebaseAuthUserAdapter(user: authDataResult.user))
        
        
        func getAuthenticatedUser() throws -> AuthDataResultModel{
            guard let user = Auth.auth().currentUser else {
                throw URLError(.badServerResponse)
            }
            return AuthDataResultModel(user: FirebaseAuthUserAdapter(user: user))
        }
        
        func resetsPassword(email: String) async throws{
            try await Auth.auth().sendPasswordReset(withEmail: email)
        }
        
        func updatePassword(password: String)async throws{
            guard let user = Auth.auth().currentUser else {
                throw URLError(.badServerResponse)
            }
            try await user.updatePassword(to: password)
        }
        
        func updateEmail(email: String)async throws{
            guard let user = Auth.auth().currentUser else {
                throw URLError(.badServerResponse)
            }
            try await user.sendEmailVerification(beforeUpdatingEmail: email)
        }
    }
}

extension AuthenticationManager{
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel{
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: FirebaseAuthUserAdapter(user: authDataResult.user))
    }
}
