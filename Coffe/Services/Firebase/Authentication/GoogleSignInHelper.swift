//
//  GoogleSignInHelper.swift
//  Coffe
//
//  Created by macbook on 10.03.2024.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import Dependencies

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    let name: String?
    let email: String?
}

final class SignInGoogleHelper {

    @Dependency(\.userRepository)
    var userRepository

    @MainActor
    func signIn() async throws -> GoogleSignInResultModel {
        guard let topVC = Utilities.shared.topViewController()else {
            throw URLError(.cannotFindHost)
        }
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accesToken = gidSignInResult.user.accessToken.tokenString
        let name = gidSignInResult.user.profile?.name
        let email = gidSignInResult.user.profile?.email
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accesToken, name: name, email: email)
        userRepository.saveChanges(
                    name: name ?? "Unknown",
                    address: "Unknown Address",
                    mobile: "Unknown Mobile",
                    email: email ?? "Unknown Email"
                )
        return tokens
    }
}
