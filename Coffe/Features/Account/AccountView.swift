//
//  AccountView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//
import SwiftUI
import Combine

struct AccountView: View {
    @Environment(Coordinator.self) private var coordinator
    @Environment(AppState.self) private var appState
    @Environment(IsDarkMode.self) private var isDarkMode
    @Environment(AccountViewModel.self) private var accountViewModel
    
    @State var loginEventCancellable: AnyCancellable?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                if let user = accountViewModel.userRepository.user, appState.isSignedIn {
                    UserInfoView(user: user, logOutAction: logOut)
                } else {
                    createAuth()
                }
                Button(
                    action: {
                        isDarkMode.isDarkMode.toggle()
                        isDarkMode
                            .updateUserInterfaceStyle()
                    }) {
                    Text("Switch to \(isDarkMode.isDarkMode ? "Light" : "Dark") Mode")
                        .styledButton(usedColor: .gray.opacity(0.4))
                }
            }
            .padding(.bottom, 30)
        }
        .onChange(of: accountViewModel.userRepository.user, { _, newValue in
            if newValue != nil {
            }
        })
        .background(Color(UIColor.systemGroupedBackground))
    }
    
    func createAuth() -> some View {
        let auth = AuthButtonsView(
            onRegister: { coordinator.presentSheet(.registration, detent: .medium) }
        )
        loginEventCancellable = auth.loginEventPublisher.sink {
            coordinator.presentSheet(.loginMethod, detent: .fraction(0.35))
        }
        return auth
    }
    
    private func logOut() {
        accountViewModel.logOut()
        appState.isSignedIn = false
    }
}
