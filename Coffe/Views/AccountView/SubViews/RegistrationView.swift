//
//  RegistrationView.swift
//  Coffe
//
//  Created by macbook on 01.02.2025.
//
import SwiftUI

struct RegistrationView: View {
    @Environment(Coordinator.self) private var coordinator
    
    @State private var registrationViewModel = RegistrationViewModel(userRepository: UserRepository())
    @Binding var isSignedIn: Bool

    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create an Account")
                .font(.title2)
                .bold()

            TextField("Email", text: $registrationViewModel.email)
                .textFieldStyle()
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $registrationViewModel.password)
                .textFieldStyle()

            SecureField("Confirm Password", text: $registrationViewModel.confirmPassword)
                .textFieldStyle()
            Button("Register") {
                Task {
                    await registrationViewModel.registerUser()
                }
            }
            .styledButton(color: .brown)
            
            Button("Cancel") {
                coordinator.dismissSheet()
            }
            .styledButton(color: .red)
        }
        .padding()
    }
}




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
