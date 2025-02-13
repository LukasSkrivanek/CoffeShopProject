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
                    break
                case .google:
                    try await loginMethodViewModel.signInGoogle()
                    loginMethodViewModel.userRepository.user = await loginMethodViewModel.userRepository.fetchUser()
                }
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



