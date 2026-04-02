//
//  UserRepository.swift
//  CoffeCore
//

import Foundation
import Observation
import Dependencies

public let userKey = "userSecureKey"

@Observable
public final class UserRepository {
    private var secureStorage: any SecureStorageProtocol

    public var user: UserModel? {
        didSet {
            Task { await saveUser() }
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
            await secureStorage.save(data: userData, with: userKey)
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
        do {
            user = UserModel(id: UUID().uuidString, name: name, email: email, address: address, mobile: mobile)
            let userData = try JSONEncoder().encode(user)
            Task { await secureStorage.save(data: userData, with: userKey) }
        } catch {
            print("Error, Couldn't create user!")
        }
    }

    private func updateUser(name: String, address: String, mobile: String, email: String) {
        do {
            user?.name = name
            user?.mobile = mobile
            user?.address = address
            user?.email = email
            let userData = try JSONEncoder().encode(user)
            Task { await secureStorage.save(data: userData, with: userKey) }
        } catch {
            print("Error, Couldn't update user!")
        }
    }

    public func fetchUser() async -> UserModel? {
        guard let userData = await secureStorage.get(with: userKey) else { return nil }
        do {
            return try JSONDecoder().decode(UserModel.self, from: userData)
        } catch {
            print("Error couldn't get user")
        }
        return nil
    }

    public func removeUser() {
        Task {
            await secureStorage.delete(with: userKey)
            user = nil
        }
    }
}
