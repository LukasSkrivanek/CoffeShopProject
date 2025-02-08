//
//  AccountViewModel.swift
//  Coffe
//
//  Created by macbook on 27.02.2024.
//

import Foundation
import Observation

@Observable
final class AccountViewModel {
    var isDarkMode: Bool = false
    var isRegisterSheetPresented: Bool = false
    var loginMethod: LoginMethod? = nil
    
    
    var name = ""
    var address = ""
    var mobile = ""
    var email = ""
    
    func setup(user: UserModel?){
        name = user?.name ?? ""
        address = user?.address ?? ""
        mobile = user?.mobile ?? ""
        email = user?.email ?? ""
        
    }
    
    func signInGoogle() async throws{
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        
    }
    
    func isInvalidForm() -> Bool {
        name.isEmpty || address.isEmpty || mobile.isEmpty
    }
}
