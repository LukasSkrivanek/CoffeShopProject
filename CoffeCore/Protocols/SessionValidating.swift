//
//  SessionValidating.swift
//  CoffeCore
//

import Foundation

public protocol SessionValidating: Sendable {
    var isAuthenticated: Bool { get }
}
