//
//  AccountView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//
import SwiftUI

struct AccountView: View {
    @Environment(Coordinator.self) private var coordinator
    
    @Environment(UserRepository.self) private var userRepository
    @Environment(AccountViewModel.self) private var accountViewModel
    @Environment(AuthenticationViewModel.self) private var authenticationViewModel
    @Binding var isSignedIn: Bool
    @Environment(\.colorScheme) var colorScheme
    
    
   
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    if let user = userRepository.user {
                        UserInfoView(user: user, logOutAction: logOut)
                    } else {
                        AuthButtonsView(
                            onLogin: { coordinator.presentSheet(.loginMethod)},
                            onRegister: { accountViewModel.isRegisterSheetPresented.toggle() }
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
            
            .sheet(isPresented: .twoWay(\.isRegisterSheetPresented, on: accountViewModel)) {
                RegistrationView(isPresented: .twoWay(\.isRegisterSheetPresented, on: accountViewModel), isSignedIn: $isSignedIn)
                    .presentationDetents([.fraction(0.6)])
                    .preferredColorScheme(colorScheme)
            }
        }
    }
    
    private func logOut() {
        userRepository.removeUser()
        accountViewModel.setup(user: nil)
        isSignedIn.toggle()
    }

    private func handleLoginMethod(_ method: LoginMethod) {
        Task {
            do {
                switch method {
                case .email:
                    userRepository.user = await userRepository.fetchUser()
                case .google:
                    try await authenticationViewModel.signInGoogle()
                    userRepository.user = await userRepository.fetchUser()
                }
                accountViewModel.setup(user: userRepository.user)
                isSignedIn = true
            } catch {
                print(error)
            }
           
        }
    }
}

enum LoginMethod {
    case email, google
}
