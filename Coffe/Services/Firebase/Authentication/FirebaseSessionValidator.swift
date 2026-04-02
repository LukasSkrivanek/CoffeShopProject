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
