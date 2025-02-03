//
//  GoogleSignInHelper.swift
//  Coffe
//
//  Created by macbook on 10.03.2024.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift


struct GoogleSignInResultModel{
    let idToken: String
    let accessToken: String
    let name: String?
    let email: String?
}



final class SignInGoogleHelper{
    
    @MainActor
    func signIn() async throws  -> GoogleSignInResultModel{
        guard let topVC = Utilities.shared.topViewController()else{
            throw URLError(.cannotFindHost)
        }
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else{
            throw URLError(.badServerResponse)
        }
        let accesToken = gidSignInResult.user.accessToken.tokenString
        let name = gidSignInResult.user.profile?.name
        let email = gidSignInResult.user.profile?.email
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accesToken, name: name, email: email)
        let userRepository = UserRepository()
        
        userRepository.saveChanges(
                    name: name ?? "Unknown",
                    address: "Unknown Address", // Můžeš to nahradit skutečnou adresou, pokud ji máš
                    mobile: "Unknown Mobile",   // Můžeš to nahradit skutečným mobilem, pokud ho máš
                    email: email ?? "Unknown Email"
                )
        return tokens
    }
}
