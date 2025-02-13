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
    
    var userRepository: UserRepository
    
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
}
