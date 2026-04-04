//
//  GoogleSignInResultModel.swift
//  CoffeCore
//

import Foundation

public struct GoogleSignInResultModel: Sendable {
    public let idToken: String
    public let accessToken: String
    public let name: String?
    public let email: String?

    public init(idToken: String, accessToken: String, name: String?, email: String?) {
        self.idToken = idToken
        self.accessToken = accessToken
        self.name = name
        self.email = email
    }
}
