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
            .onChange(of: userRepository.user, { _, newValue in
                if newValue != nil {
                    
                }
            })
            .background(Color(UIColor.systemGroupedBackground))
           
            
        }
    private func logOut() {
        do {
            try AuthenticationManager.shared.signOut()
            userRepository.removeUser()
        } catch  {
            print("Chyba")
        }
    }
}
