//
//  IsDarkMode.swift
//  Coffe
//
//  Created by macbook on 14.02.2025.
//

import SwiftUI


@Observable
final class IsDarkMode {
    var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
            print("\(isDarkMode)")
            updateUserInterfaceStyle()
        }
    }
    
    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        updateUserInterfaceStyle()
    }
    
    func updateUserInterfaceStyle() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first else {
                return
            }
            window.overrideUserInterfaceStyle = self.isDarkMode ? .dark : .light
        }
    }

}

