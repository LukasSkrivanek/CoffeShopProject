//
//  LoginMethodSelectionView.swift
//  Coffe
//
//  Created by macbook on 01.02.2025.
//
import SwiftUI
import CoffeCore

struct LoginMethodSelectionView: View {
    
    @Environment(Coordinator.self)
    private var coordinator
    @Environment(AppState.self)
    private var appState

    @State
    private var viewModel = LoginMethodSelectionViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Select Login Method")
                .font(.title2)
                .bold()
            Button(action: {
                coordinator.presentSheet(.login)

            }, label: {
                Text("Login with Email")
                    .styledButton(usedColor: .brown)
            })
            Button(action: {
                handleLoginMethod(.google)
            }, label: {
                Text("Login with Google")
                    .styledButton(usedColor: .oliveGreen)
            })
        }
        .padding()
    }
    private func handleLoginMethod(_ method: LoginMethod) {
        Task {
            do {
                switch method {
                case .email:
                    break
                case .google:
                    let tokens = try await SignInGoogleHelper().signIn()
                    try await viewModel.signInWithGoogle(tokens: tokens)
                    appState.isSignedIn = true
                }
                coordinator.dismissSheet()
            } catch {
                print(error)
            }
        }
    }
}
