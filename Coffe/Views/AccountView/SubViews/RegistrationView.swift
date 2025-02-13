//
//  RegistrationView.swift
//  Coffe
//
//  Created by macbook on 01.02.2025.
//
import SwiftUI

struct RegistrationView: View {
    @Environment(Coordinator.self) private var coordinator
    
    @Environment(RegistrationViewModel.self) private var registrationViewModel
    
    var body: some View {
        @Bindable var registrationViewModel = registrationViewModel
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
            Button {
                Task {
                    await registrationViewModel.registerUser()
                }
                coordinator.dismissSheet()
            } label: {
                Text("Register")
                    .styledButton(usedColor: .brown)
            }

            Button {
                coordinator.dismissSheet()
            } label: {
                Text("Cancel")
                    .styledButton(usedColor: .red)
            }
        }
        .padding()
    }
}
