//
//  AppTabView.swift
//  CoffeTests
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI

struct AppTabView: View {
    @Environment(UserRepository.self) private var  userRepository
    @Environment(AccountViewModel.self) private var accountViewModel
    @State var isSignedIn: Bool = true
    @State var authenticationViewModel = AuthenticationViewModel()
    var body: some View {
        TabView{
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            BasketView()
                .tabItem{
                    Image(systemName: "bag")
                    Text("Basket")
                }
            AccountView(isSignedIn: $isSignedIn)
                .tabItem{
                    Image(systemName: "bag")
                    Text("Setting")
                }
            
        }
        .onAppear {
            // Zjistíme, zda je uživatel přihlášen
            if  let user = userRepository.user  {
                accountViewModel.setup(user: user)
                print(user)
                isSignedIn = true
            } else {
                isSignedIn = false
            }
        }
    }
}

#Preview {
    AppTabView()
}
