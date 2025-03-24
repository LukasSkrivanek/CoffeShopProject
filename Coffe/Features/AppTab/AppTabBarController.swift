//
//  AppTabBarController.swift
//  Coffe
//
//  Created by macbook on 24.03.2025.
//
import UIKit
import SwiftUI

final class AppTabBarController: UITabBarController {

    // MARK: - Properties
    var childCoordinators = [Coordinator]()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    // MARK: - Setup
    private func setupTabBar() {
        let drinkListVC = makeDrinkListViewController()
        let basketVC = makeBasketViewController()
        let accountVC = makeAccountViewController()
        viewControllers = [
            wrapInNavigationController(drinkListVC),
            wrapInNavigationController(basketVC),
            wrapInNavigationController(accountVC)
        ]
        tabBar.tintColor = .brown
        delegate = self
    }
    // MARK: - View Controller Factories
    private func makeDrinkListViewController() -> UIViewController {
        let vc = DrinkListViewController()
        vc.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        return vc
    }
    private func makeBasketViewController() -> UIViewController {
        let vc = UIHostingController(rootView: BasketView())
        vc.tabBarItem = UITabBarItem(
            title: "Basket",
            image: UIImage(systemName: "bag"),
            tag: 1
        )
        return vc
    }
    private func makeAccountViewController() -> UIViewController {
        let vc = UIHostingController(rootView: AccountView())
        vc.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "person"),
            tag: 2
        )
        return vc
    }
    private func wrapInNavigationController(_ vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
}
// MARK: - UITabBarControllerDelegate
extension AppTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController === tabBarController.viewControllers?.last {
        }
    }
}
