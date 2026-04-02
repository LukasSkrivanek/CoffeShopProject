//
//  AppearanceState.swift
//  Coffe
//

import SwiftUI

enum AppearanceMode: String, CaseIterable {
    case light, dark, system

    var colorScheme: ColorScheme? {
        switch self {
        case .light:
            .light
        case .dark:
            .dark
        case .system:
            nil
        }
    }

    var label: String {
        switch self {
        case .light:
            "Light"
        case .dark:
            "Dark"
        case .system:
            "System"
        }
    }
}

@MainActor
@Observable
final class AppearanceState {
    var mode: AppearanceMode {
        didSet { UserDefaults.standard.set(mode.rawValue, forKey: "appearanceMode") }
    }

    init() {
        let saved = UserDefaults.standard.string(forKey: "appearanceMode") ?? ""
        self.mode = AppearanceMode(rawValue: saved) ?? .system
    }
}
