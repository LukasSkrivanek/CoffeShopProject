//
//  AppPages.swift
//  Coffe
//
//  Created by macbook on 07.02.2025.
//

import Foundation


enum AppPages {
    case appTabBar
    case home
    case account
    case basket
}

enum Sheet: String, Identifiable {
    var id: String {
        self.rawValue
    }
    
    case loginMethod
    case registration
}


enum FullScreenCorver: String, Identifiable {
    var id: String {
        self.rawValue
    }
    
    case zero
    
    
}
