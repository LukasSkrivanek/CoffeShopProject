//
//  SecureStorage.swift
//  Coffe
//

import Foundation
import KeychainAccess
import CoffeCore

@Observable
final class SecureStorage: SecureStorageProtocol {
    private static let keychain = Keychain(service: "luky.skrivos-gmail.com.Coffe")

    func save(data: Data, with key: String) async {
        SecureStorage.keychain[data: key] = data
    }

    func get(with key: String) async -> Data? {
        SecureStorage.keychain[data: key]
    }

    func delete(with key: String) async {
        SecureStorage.keychain[key] = nil
    }
}
