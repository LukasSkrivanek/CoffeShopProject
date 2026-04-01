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

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environment(isDarkMode)
                .environment(coordinator)
                .environment(appState)
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
