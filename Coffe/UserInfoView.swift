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
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                Text("Welcome")
                    .font(.title3)
                    .foregroundColor(.gray)
                Text(user.email)
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                Text(user.address)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)

            Button(action: logOutAction) {
                Text("Log Out")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 3)
            }
        }
        .padding(.horizontal)
    }
}

struct AuthButtonsView: View {
    let onLogin: () -> Void
    let onRegister: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            Text("Please log in or register to continue.")
                .padding()

            Button(action: onLogin) {
                Text("Login")
                    .styledButton(usedColor: .brown)
            }
            Button(action: onRegister) {
                Text("Register")
                    .styledButton(usedColor: .oliveGreen)
            }
        }
    }
}
