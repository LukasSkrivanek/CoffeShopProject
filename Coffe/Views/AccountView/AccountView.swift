//
//  AccountView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//
import SwiftUI

struct AccountView: View {
    @Environment(Coordinator.self) private var coordinator
    @Environment(AppState.self) private var appState
    
    @Environment(UserRepository.self) private var userRepository
    @Environment(AccountViewModel.self) private var accountViewModel
    
    var body: some View {
            ScrollView {
                VStack(spacing: 15) {
                    if let user = userRepository.user {
                        UserInfoView(user: user, logOutAction: logOut)
                    } else {
                        AuthButtonsView(
                            onLogin: { coordinator.presentSheet(.loginMethod, detent: .fraction(0.35))},
                            onRegister: { coordinator.presentSheet(.registration, detent: .medium) }
                        )
                    }
                    
                    DarkModeToggle(isDarkMode: .twoWay(\.isDarkMode, on: accountViewModel))
                }
                .padding(.bottom, 30)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .onAppear {
                if let user = userRepository.user {
                    accountViewModel.setup(user: user)
                }
            }
        }
    private func logOut() {
        userRepository.removeUser()
        accountViewModel.setup(user: nil)
        appState.isSignedIn.toggle()
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
            } catch {
                print(error)
            }
           
        }
    }
}
