//
//  User.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import Foundation

struct UserModel: Codable, Equatable {
    let id: String
    var name: String
    var email: String
    var address: String
    var mobile: String
}
