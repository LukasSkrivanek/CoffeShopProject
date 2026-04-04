//
//  UserRepository.swift
//  CoffeCore
//

import Foundation
import Observation
import Dependencies

@Observable
public final class UserRepository {
    private static let userKey = "userSecureKey"
    private var secureStorage: any SecureStorageProtocol

    @ObservationIgnored private var saveTask: Task<Void, Never>?

    public var user: UserModel? {
        didSet {
            saveTask?.cancel()
            saveTask = Task { await saveUser() }
        }
    }

    public init(secureStorage: any SecureStorageProtocol) {
        self.secureStorage = secureStorage
        Task { user = await loadUser() }
    }

    @MainActor
    private func loadUser() async -> UserModel? {
        await fetchUser()
    }

    private func saveUser() async {
        guard let user else { return }
        do {
            let userData = try JSONEncoder().encode(user)
            await secureStorage.save(data: userData, with: Self.userKey)
        } catch {
            print("Error saving user!")
        }
    }

    public func saveChanges(name: String, address: String, mobile: String, email: String) {
        if user != nil {
            updateUser(name: name, address: address, mobile: mobile, email: email)
        } else {
            createUser(name: name, address: address, mobile: mobile, email: email)
        }
    }

    public func createUser(name: String, address: String, mobile: String, email: String) {
        user = UserModel(id: UUID().uuidString, name: name, email: email, address: address, mobile: mobile)
    }

    private func updateUser(name: String, address: String, mobile: String, email: String) {
        guard var updated = user else { return }
        updated.name = name
        updated.mobile = mobile
        updated.address = address
        updated.email = email
        user = updated
    }

    public func fetchUser() async -> UserModel? {
        guard let userData = await secureStorage.get(with: Self.userKey) else { return nil }
        do {
            return try JSONDecoder().decode(UserModel.self, from: userData)
        } catch {
            print("Error couldn't get user")
            return nil
        }
    }

    public func removeUser() {
        Task {
            await secureStorage.delete(with: Self.userKey)
            user = nil
        }
    }
}
