//
//  AppState.swift
//  Coffe
//
//  Created by macbook on 08.02.2025.
//

import SwiftUI

@MainActor
@Observable
class AppState {
    var isSignedIn: Bool {
        didSet {
            UserDefaults.standard.set(isSignedIn, forKey: "isSignedIn")
        }
    }

    init() {
        self.isSignedIn = UserDefaults.standard.bool(forKey: "isSignedIn")
    }
}
