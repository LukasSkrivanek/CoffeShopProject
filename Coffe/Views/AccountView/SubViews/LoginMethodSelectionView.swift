//
//  LoginMethodSelectionView.swift
//  Coffe
//
//  Created by macbook on 01.02.2025.
//
import SwiftUI

struct LoginMethodSelectionView: View {
    @Environment(Coordinator.self) private var coordinator
    @Environment(AppState.self) private var appState
    @Environment(AccountViewModel.self) private var accountViewModel
    @Environment(UserRepository.self) private var userRepository
    @Environment(LoginMethodSelectionViewModel.self) private var loginMethodViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select Login Method")
                .font(.title2)
                .bold()
            
            Button(action: {
                coordinator.presentSheet(.login)

            }, label: {
                Text("Login with Email")
                    .styledButton(color: .brown)
            })
            
            
            Button(action: {
                handleLoginMethod(.google)
            }, label: {
                Text("Login with Google")
                    .styledButton(color: .oliveGreen)
            })
            
        }
        .padding()

    }
    private func handleLoginMethod(_ method: LoginMethod) {
        Task {
            do {
                switch method {
                case .email:
                    userRepository.user = await userRepository.fetchUser()
                case .google:
                    try await accountViewModel.signInGoogle()
                    userRepository.user = await userRepository.fetchUser()
                }
                accountViewModel.setup(user: userRepository.user)
                appState.isSignedIn = true
                coordinator.dismissSheet()
            } catch {
                print(error)
            }
           
        }
    }
    
    
}

enum LoginMethod {
    case email, google
}



