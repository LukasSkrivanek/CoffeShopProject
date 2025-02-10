//
//  AuthDataResultModel.swift
//  Coffe
//
//  Created by macbook on 10.02.2025.
//
import Foundation

protocol AuthUserProtocol {
    var uid: String { get }
    var email: String? { get }
}


struct AuthDataResultModel {
    let uid: String
    let email: String?
    let user: AuthUserProtocol 
    
    init(user: AuthUserProtocol) {
        self.uid = user.uid
        self.email = user.email
        self.user = user
    }
}

