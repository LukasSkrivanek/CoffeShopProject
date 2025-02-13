//
//  LoginSheetView.swift
//  Coffe
//
//  Created by macbook on 10.02.2025.
//
import SwiftUI

struct LoginSheetView: View {
    @Environment(Coordinator.self) private var coordinator
    @Environment(AppState.self) private var appState
    
    @Environment(LoginViewModel.self) private var loginViewModel
    
    var body: some View {
        @Bindable var loginViewModel = loginViewModel
        VStack(spacing: 20) {
            Text("Login")
                .font(.title2)
                .bold()

            TextField("Email", text: $loginViewModel.email)
                .textFieldStyle()
                .autocapitalization(.none)
                .keyboardType(.emailAddress)

            SecureField("Password", text: $loginViewModel.password)
                .textFieldStyle()

            Button {
                Task {
                    await loginViewModel.loginUser()
                    appState.isSignedIn = true
            
                    loginViewModel.email = ""
                    loginViewModel.password = ""
                    coordinator.dismissSheet()
                }
            } label: {
                Text("Login")
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
