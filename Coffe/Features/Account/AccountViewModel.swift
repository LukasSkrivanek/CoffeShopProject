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
    var userRepository: UserRepository
    var authenticationManager: AuthenticationManager
    
    var name = ""
    var address = ""
    var mobile = ""
    var email = ""
    
    init(userRepository: UserRepository , authenticationManager: AuthenticationManager) {
        self.userRepository = userRepository
        self.authenticationManager = authenticationManager
        
    }

    func isInvalidForm() -> Bool {
        name.isEmpty || address.isEmpty || mobile.isEmpty
    }
    
    func logOut()   {
        do {
            try authenticationManager.signOut()
            userRepository.removeUser()
        } catch  {
            print("Error")
        }
        
    }
}
