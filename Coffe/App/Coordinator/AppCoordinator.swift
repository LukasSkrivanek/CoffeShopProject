//
//  AppCoordinator.swift
//  Coffe
//
//  Created by macbook on 24.03.2025.
//
import SwiftUI
import UIKit
import SwifterSwift

protocol Coordinator {
    func openDrinksList()
    func openBasketList()
    func openAccountScreen()
}

extension Coordinator {
    func start() {
        openDrinksList()
    }
}

class AppCoordinator: Coordinator {
    weak var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    // TODO: make this work
    /*private func setupWindow() {
        window ?= {
            let result = UIWindow(frame: UIScreen.main.bounds)
            result.makeKeyAndVisible()
            return result
        }()
    }*/

    private func setupRootController() {
        window?.rootViewController ?= AppTabBarController()
    }
    
    func openDrinksList() {
        setupRootController()
        (window?.rootViewController as? AppTabBarController)?.open(tab: .drinks)
    }
    
    func openBasketList() {
        setupRootController()
        (window?.rootViewController as? AppTabBarController)?.open(tab: .basket)
    }
    
    func openAccountScreen() {
        setupRootController()
        (window?.rootViewController as? AppTabBarController)?.open(tab: .account)
    }
}
