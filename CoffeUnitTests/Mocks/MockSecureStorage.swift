//
//  MockSecureStorage.swift
//  Coffe
//
//  Created by macbook on 20.03.2025.
//

import Foundation
@testable import Coffe

class MockSecureStorage: SecureStorageProtocol {
    var savedData: Data?
    var keyUsed: String?

    func save(data: Data, with key: String) async {
        savedData = data
        keyUsed = key
    }

    func get(with key: String) async -> Data? {
        return savedData
    }

    func delete(with key: String) async {
        savedData = nil
        keyUsed = key
    }
}
