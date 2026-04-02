//
//  CoffeApp.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//
import SwiftUI
import FirebaseCore
import Dependencies
import CoffeCore

@main
struct CoffeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        prepareDependencies {
            let secureStorage = SecureStorage()
            $0.drinkRepository = FirebaseRepository()
            $0.authService = FirebaseAuthServiceAdapter()
            $0.sessionValidator = FirebaseSessionValidator()
            $0.secureStorage = secureStorage
            $0.userRepository = UserRepository(secureStorage: secureStorage)
        }
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.brown)
    }

    @State private var coordinator = Coordinator()
    @State private var appState = AppState()
    @State private var basketState = BasketState()
    @State private var appearanceState = AppearanceState()

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .preferredColorScheme(appearanceState.mode.colorScheme)
                .environment(coordinator)
                .environment(appState)
                .environment(basketState)
                .environment(appearanceState)
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
