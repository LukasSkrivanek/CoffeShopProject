//
//  IsDarkMode.swift
//  Coffe
//
//  Created by macbook on 14.02.2025.
//

import SwiftUI

@MainActor
@Observable
final class IsDarkMode {
    static let shared = IsDarkMode()
    var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
    
    private init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
    
    func updateUserInterfaceStyle() {
        if isDarkMode {
                  // Nastavení tmavého režimu
                  UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
              } else {
                  // Nastavení světlého režimu
                  UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
              }           }
       }

