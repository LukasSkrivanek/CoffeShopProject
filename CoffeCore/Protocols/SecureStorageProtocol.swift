//
//  SecureStorageProtocol.swift
//  CoffeCore
//

import Foundation

public protocol SecureStorageProtocol: Sendable {
    func save(data: Data, with key: String) async
    func get(with key: String) async -> Data?
    func delete(with key: String) async
}
