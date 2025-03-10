//
//  AppPages.swift
//  Coffe
//
//  Created by macbook on 07.02.2025.
//

import Foundation

enum AppPages: Hashable {
    case appTabBar
    case drinkList
    case account
    case basket
    case drinkDetail(Drink)
}

enum Sheet: String, Identifiable {
    var id: String {
        self.rawValue
    }
    case loginMethod
    case registration
    case login
}

enum FullScreenCorver: String, Identifiable {
    var id: String {
        self.rawValue
    }
    case zero
}
