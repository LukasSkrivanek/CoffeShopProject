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
    @Environment(\.colorScheme) private var colorScheme
    @Environment(LoginViewModel.self) private var loginViewModel
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.title2)
                .bold()
            TextField("Email", text: .twoWay(\.email, on: loginViewModel))
                .textFieldStyle()
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            SecureField("Password", text: .twoWay(\.password, on: loginViewModel))
                .textFieldStyle()
            Button {
                Task {
                    if await loginViewModel.loginUser() {
                        loginViewModel.email = ""
                        loginViewModel.password = ""
                        appState.isSignedIn = true
                        coordinator.dismissSheet()
                    }
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
        .showCustomAlert(alert: .twoWay(\.alert, on: loginViewModel), colorScheme: .dark)
        .padding()
    }
}
