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

    @State private var isDarkMode = IsDarkMode()
    @State private var coordinator = Coordinator()
    @State private var appState = AppState()
    @State private var basketViewModel = BasketViewModel()
    @State private var drinkListViewModel = DrinkListViewModel()
    @State private var accountViewModel = AccountViewModel()
    @State private var registrationViewModel = RegistrationViewModel()
    @State private var loginViewModel = LoginViewModel()
    @State private var loginMethodSelectionViewModel = LoginMethodSelectionViewModel()

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environment(isDarkMode)
                .environment(coordinator)
                .environment(appState)
                .environment(basketViewModel)
                .environment(drinkListViewModel)
                .environment(accountViewModel)
                .environment(registrationViewModel)
                .environment(loginViewModel)
                .environment(loginMethodSelectionViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
