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
    
    var isRegisterSheetPresented: Bool = false
    var loginMethod: LoginMethod? = nil
    var isDarkMode: Bool {
            didSet {
                UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
            }
        }
    
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        print("Setting isDarkMode to: \(self.isDarkMode)")
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
