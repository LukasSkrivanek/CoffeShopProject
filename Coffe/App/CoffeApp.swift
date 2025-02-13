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
                .environment(DependencyContainer.resolve(Coordinator.self))
                .environment(DependencyContainer.resolve(RegistrationViewModel.self))
                .environment(DependencyContainer.resolve(LoginViewModel.self))
                .environment(DependencyContainer.resolve(AppState.self))
                .environment(DependencyContainer.resolve(LoginMethodSelectionViewModel.self))
                .environment(DependencyContainer.resolve(BasketViewModel.self))
                .environment(DependencyContainer.resolve(UserRepository.self))
                .environment(DependencyContainer.resolve(HomeViewModel.self))
                .environment(DependencyContainer.resolve(AccountViewModel.self))
                .environment(DependencyContainer.resolve(SecureStorage.self))
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
