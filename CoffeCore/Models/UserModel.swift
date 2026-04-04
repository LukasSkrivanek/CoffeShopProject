//
//  UserModel.swift
//  CoffeCore
//

import Foundation

public struct UserModel: Codable, Equatable {
    public let id: String
    public var name: String
    public var email: String
    public var address: String
    public var mobile: String

    public init(id: String, name: String, email: String, address: String, mobile: String) {
        self.id = id
        self.name = name
        self.email = email
        self.address = address
        self.mobile = mobile
    }
}
