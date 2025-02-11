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
                coordinator.dismissSheet()
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
