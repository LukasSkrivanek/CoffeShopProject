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
    
    var isDarkMode: Bool = false
    var isRegisterSheetPresented: Bool = false
    var loginMethod: LoginMethod? = nil
    
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    var name = ""
    var address = ""
    var mobile = ""
    var email = ""
    
    
    func isInvalidForm() -> Bool {
        name.isEmpty || address.isEmpty || mobile.isEmpty
    }
    
    func logOut()   {
        do {
            try AuthenticationManager.shared.signOut()
            userRepository.removeUser()
        } catch  {
            print("Error")
        }
        
    }
}
