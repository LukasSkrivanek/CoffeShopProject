//
//  CoffeApp.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//
import UIKit
import SwiftUI
import FirebaseCore

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
        self.appCoordinator = appCoordinator
        return true
    }
}
