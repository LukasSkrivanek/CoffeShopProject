//
//  RegistrationViewModel.swift
//  Coffe
//
//  Created by macbook on 08.02.2025.
//
import Foundation

@Observable
class RegistrationViewModel {
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var errorMessage: String? = nil
    
    private var userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func registerUser() async {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }
        
        do {
            try await AuthenticationManager.shared.createUser(email: email, password: password)
            userRepository.user = await userRepository.fetchUser()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
