//
//  UserInfoView.swift
//  Coffe
//
//  Created by macbook on 01.02.2025.
//
import SwiftUI

struct UserInfoView: View {
    let user: UserModel
    let logOutAction: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            Text("Welcome, \(user.email)")
                .font(.title2)
                .bold()
                .padding(.top, 20)

            Button(action: logOutAction) {
                Text("Log Out")
                    .styledButton(color: .red)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct AuthButtonsView: View {
    let onLogin: () -> Void
    let onRegister: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            Text("Please log in or register to continue.")
                .padding()

            Button("Login", action: onLogin)
                .styledButton()

            Button("Register", action: onRegister)
                .styledButton(color: .green)
        }
    }
}

struct DarkModeToggle: View {
    @Binding var isDarkMode: Bool

    var body: some View {
        Button(action: {
            isDarkMode.toggle()
            UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }) {
            Text("Switch to \(isDarkMode ? "Light" : "Dark") Mode")
                .styledButton(color: .gray.opacity(0.4))
        }
        
    }
}

extension View {
    func styledButton(color: Color = .blue) -> some View {
        self
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(radius: 5)
            .padding(.horizontal)
    }
}
