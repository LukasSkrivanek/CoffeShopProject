//
//  AppState.swift
//  Coffe
//

import SwiftUI

@MainActor
@Observable
final class AppState {
    var isSignedIn: Bool {
        didSet { UserDefaults.standard.set(isSignedIn, forKey: "isSignedIn") }
    }

    init() {
        self.isSignedIn = UserDefaults.standard.bool(forKey: "isSignedIn")
    }
}
