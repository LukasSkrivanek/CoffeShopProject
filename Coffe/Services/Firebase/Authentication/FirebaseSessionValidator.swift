//
//  FirebaseSessionValidator.swift
//  Coffe
//

import FirebaseAuth
import Dependencies
import CoffeCore

struct FirebaseSessionValidator: SessionValidating {
    var isAuthenticated: Bool {
        Auth.auth().currentUser != nil
    }
}

extension SessionValidatorKey: DependencyKey {
    public static var liveValue: any SessionValidating { FirebaseSessionValidator() }
}
