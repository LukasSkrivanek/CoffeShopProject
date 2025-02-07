//
//  CoffeApp.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//
import SwiftUI
import FirebaseCore

@main
struct CoffeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environment(Coordinator())
                .environment(DependencyContainer.shared.resolve(LoginMethodSelectionViewModel.self))
                .environment(DependencyContainer.shared.resolve(BasketViewModel.self))
                .environment(DependencyContainer.shared.resolve(UserRepository.self))
                .environment(DependencyContainer.shared.resolve(HomeViewModel.self))
                .environment(DependencyContainer.shared.resolve(AccountViewModel.self))
                .environment(DependencyContainer.shared.resolve(AuthenticationViewModel.self))
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
