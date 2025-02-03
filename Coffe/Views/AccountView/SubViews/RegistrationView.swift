//
//  RegistrationView.swift
//  Coffe
//
//  Created by macbook on 01.02.2025.
//
import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Binding var isPresented: Bool
    @Binding var isSignedIn: Bool
    @Environment(UserRepository.self) private var userRepository
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create an Account")
                .font(.title2)
                .bold()

            TextField("Email", text: $email)
                .textFieldStyle()
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $password)
                .textFieldStyle()

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle()
            Button("Register") {
                Task {
                    await registerUser()
                }
            }
            .styledButton(color: .green)
            
            Button("Cancel") {
                isPresented.toggle()
            }
            .styledButton(color: .gray)
        }
        .padding()
    }
    
    private func registerUser() async {
        guard password == confirmPassword else {
            print("Passwords do not match")
            return
        }
        
        do {
            let newUser = try await AuthenticationManager.shared.createUser(email: email, password: password)
            userRepository.user = await userRepository.fetchUser()
            isSignedIn = true
            isPresented.toggle()
            print("User registered: \(newUser.email ?? "No email")")
        } catch {
            print("Registration failed: \(error.localizedDescription)")
        }
    }
}
