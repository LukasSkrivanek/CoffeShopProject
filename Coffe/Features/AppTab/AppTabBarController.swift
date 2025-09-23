//
//  AppTabBarController.swift
//  Coffe
//
//  Created by macbook on 24.03.2025.
//
import UIKit
import SwiftUI
import SwifterSwift

enum Tab: Int, CaseIterable {
    case drinks = 0
    case basket = 1
    case account = 2
}

final class AppTabBarController: UITabBarController {

    // MARK: - Properties

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

        // TODO: make this work
        /*viewControllers = []
        viewControllers?.insert(wrapInNavigationController(drinkListVC), at: Tab.drinks.rawValue)
        viewControllers?.insert(wrapInNavigationController(basketVC), at: Tab.basket.rawValue)
        viewControllers?.insert(wrapInNavigationController(accountVC), at: Tab.account.rawValue)*/
        
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
        let vc = DrinkListViewController(store: .init(initialState: .init(), reducer: {
            DrinkList()
        }))
        vc.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: Tab.drinks.rawValue
        )
        return vc
    }
    private func makeBasketViewController() -> UIViewController {
        let vc = UIHostingController(rootView: BasketView())
        vc.tabBarItem = UITabBarItem(
            title: "Basket",
            image: UIImage(systemName: "bag"),
            tag: Tab.basket.rawValue
        )
        return vc
    }
    private func makeAccountViewController() -> UIViewController {
        let vc = UIHostingController(rootView: AccountView())
        vc.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "person"),
            tag: Tab.account.rawValue
        )
        return vc
    }
    private func wrapInNavigationController(_ vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
    
    func open(tab: Tab) {
        selectedIndex = tab.rawValue
    }
    
    func screen(for tab: Tab) -> UIViewController? {
        viewControllers?[safe: tab.rawValue]
    }
}
// MARK: - UITabBarControllerDelegate
extension AppTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController === tabBarController.viewControllers?.last {
        }
    }
}
