//
//  AppTabView.swift
//  CoffeTests
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI

struct AppTabView: View {
    @Environment(Coordinator.self) private var coordinator
    
    @Environment(UserRepository.self) private var  userRepository
    @Environment(AccountViewModel.self) private var accountViewModel
    
    
    @State var isSignedIn: Bool = true
    var body: some View {
        TabView{
            coordinator.build(page: .home)
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            coordinator.build(page: .basket)
                .tabItem{
                    Image(systemName: "bag")
                    Text("Basket")
                }
            coordinator.build(page: .account)
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
