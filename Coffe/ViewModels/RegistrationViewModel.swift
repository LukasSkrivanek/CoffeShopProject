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
    var isSignedIn: Bool = false
    
    private var userRepository: UserRepository
    
    // Inicializace s předáním UserRepository
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
            isSignedIn = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
