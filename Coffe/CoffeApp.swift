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
