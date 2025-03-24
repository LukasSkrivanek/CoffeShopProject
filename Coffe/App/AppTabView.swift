//
//  AppTabView.swift
//  CoffeTests
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI

struct AppTabView: View {
   // @Environment(Coordinator.self) private var coordinator
    @Environment(AccountViewModel.self) private var accountViewModel
    var body: some View {
            TabView {
              
            }
        .tint(.brown)
    }
}

#Preview {
    AppTabView()
        //.environment(Coordinator())
        .environment(UserRepository(secureStorage: SecureStorage()))
        .environment(
            AccountViewModel(
                userRepository: UserRepository(
                    secureStorage: SecureStorage()
                ),
                authenticationManager: AuthenticationManager(
                    authServiceProtocol: FirebaseAuthServiceAdapter()
                )
            )
        )
       
        .environment(
            BasketViewModel(
                userRepository: UserRepository(
                    secureStorage: SecureStorage()
                ),
                firebaseRepository: FirebaseRepository()
            )
        )
}
