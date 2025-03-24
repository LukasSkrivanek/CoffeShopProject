//
//  CoffeApp.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//
import UIKit
import SwiftUI
import FirebaseCore

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let contentView = CoordinatorView()
            .environment(DependencyContainer.resolve(IsDarkMode.self))
            .environment(DependencyContainer.resolve(Coordinator.self))
            .environment(DependencyContainer.resolve(AppState.self))
            .environment(DependencyContainer.resolve(BasketViewModel.self))
            .environment(DependencyContainer.resolve(DrinkListViewModel.self))
            .environment(DependencyContainer.resolve(AccountViewModel.self))
            .environment(DependencyContainer.resolve(RegistrationViewModel.self))
            .environment(DependencyContainer.resolve(LoginViewModel.self))
            .environment(DependencyContainer.resolve(LoginMethodSelectionViewModel.self))
            .environment(DependencyContainer.resolve(UserRepository.self))
            .environment(DependencyContainer.resolve(SecureStorage.self))

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController =  UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
