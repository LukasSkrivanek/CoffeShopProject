//
//  AppCoordinator.swift
//  Coffe
//
//  Created by macbook on 24.03.2025.
//
import SwiftUI
import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    func start() {
        window.rootViewController =  AppTabBarController()
        window.makeKeyAndVisible()
    }
}
