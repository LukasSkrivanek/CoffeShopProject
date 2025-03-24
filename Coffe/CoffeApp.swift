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
    var appCoordinator: AppCoordinator?
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let appCoordinator = AppCoordinator(window: window)
            appCoordinator.start()
            self.appCoordinator = appCoordinator
            window.makeKeyAndVisible()
        }
    }
}
