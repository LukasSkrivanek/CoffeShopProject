//
//  AuthDataResultModel.swift
//  CoffeCore
//

import Foundation

public protocol AuthUserProtocol: Sendable {
    var uid: String { get }
    var email: String? { get }
}

public struct AuthDataResultModel: Sendable {
    public let uid: String
    public let email: String?

    public init(user: any AuthUserProtocol) {
        self.uid = user.uid
        self.email = user.email
    }
}
