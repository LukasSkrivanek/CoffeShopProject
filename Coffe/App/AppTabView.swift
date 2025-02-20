//
//  AppTabView.swift
//  CoffeTests
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI

struct AppTabView: View {
    @Environment(Coordinator.self) private var coordinator
    @Environment(AccountViewModel.self) private var accountViewModel
    var body: some View {
            TabView {
                coordinator.build(page: .drinkList)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                coordinator.build(page: .basket)
                    .tabItem {
                        Image(systemName: "bag")
                        Text("Basket")
                    }
                coordinator.build(page: .account)
                    .tabItem {
                        Image(systemName: "bag")
                        Text("Setting")
                    }
            }
        .tint(.brown)
    }
}

#Preview {
    AppTabView()
        .environment(Coordinator())
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
        .environment(DrinkListViewModel(firebaseRepository: FirebaseRepository()))
        .environment(
            BasketViewModel(
                userRepository: UserRepository(
                    secureStorage: SecureStorage()
                ),
                firebaseRepository: FirebaseRepository()
            )
        )
}
