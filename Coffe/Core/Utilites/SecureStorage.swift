//
//  SecureStorage.swift
//  Coffe
//
//  Created by macbook on 27.02.2024.
//

import Foundation
import KeychainAccess

let userKey = "userSecureKey"

protocol SecureStorageProtocol {
    func save(data: Data, with key: String) async
    func get(with key: String)async -> Data?
    func delete(with key: String) async
}

@Observable
final class SecureStorage: SecureStorageProtocol {
    private static let keychain = Keychain(service: "luky.skrivos-gmail.com.Coffe")
    func save(data: Data, with key: String) async {
        SecureStorage.keychain[data: key] = data
    }
    func get(with key: String)async -> Data? {
        SecureStorage.keychain[data: key]
    }
    func delete(with key: String) async {
        SecureStorage.keychain[key] = nil
    }
}
