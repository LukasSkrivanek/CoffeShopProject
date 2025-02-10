//
//  FirebaseAuthUserAdapter.swift
//  Coffe
//
//  Created by macbook on 10.02.2025.
//

import Swift
import FirebaseAuth

struct FirebaseAuthUserAdapter: AuthUserProtocol {
    let uid: String
    let email: String?

    init(user: FirebaseAuth.User) {
        self.uid = user.uid
        self.email = user.email
    }
}
