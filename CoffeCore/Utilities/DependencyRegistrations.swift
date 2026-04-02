//
//  DependencyRegistrations.swift
//  CoffeCore
//

import Dependencies
import Foundation

// MARK: - DrinkRepository

public enum DrinkRepositoryKey: TestDependencyKey {
    public static let testValue: any DrinkRepositoryProtocol = UnimplementedDrinkRepository()
}

extension DependencyValues {
    public var drinkRepository: any DrinkRepositoryProtocol {
        get { self[DrinkRepositoryKey.self] }
        set { self[DrinkRepositoryKey.self] = newValue }
    }
}

// MARK: - AuthService

public enum AuthServiceKey: TestDependencyKey {
    public static let testValue: any AuthServiceProtocol = UnimplementedAuthService()
}

extension DependencyValues {
    public var authService: any AuthServiceProtocol {
        get { self[AuthServiceKey.self] }
        set { self[AuthServiceKey.self] = newValue }
    }
}

// MARK: - SessionValidator

public enum SessionValidatorKey: TestDependencyKey {
    public static let testValue: any SessionValidating = UnimplementedSessionValidator()
}

extension DependencyValues {
    public var sessionValidator: any SessionValidating {
        get { self[SessionValidatorKey.self] }
        set { self[SessionValidatorKey.self] = newValue }
    }
}

// MARK: - SecureStorage

public enum SecureStorageKey: TestDependencyKey {
    public static let testValue: any SecureStorageProtocol = EmptySecureStorage()
}

extension DependencyValues {
    public var secureStorage: any SecureStorageProtocol {
        get { self[SecureStorageKey.self] }
        set { self[SecureStorageKey.self] = newValue }
    }
}

// MARK: - UserRepository

public enum UserRepositoryKey: TestDependencyKey {
    public static var testValue: UserRepository = UserRepository(secureStorage: EmptySecureStorage())
}

extension DependencyValues {
    public var userRepository: UserRepository {
        get { self[UserRepositoryKey.self] }
        set { self[UserRepositoryKey.self] = newValue }
    }
}

// MARK: - Test doubles

private struct UnimplementedDrinkRepository: DrinkRepositoryProtocol {
    func fetchDrinks() async throws -> [Drink] { [] }
    func placeOrder(order: Order) async throws {}
}

private struct UnimplementedAuthService: AuthServiceProtocol {
    func createUser(email: String, password: String) async throws -> AuthDataResultModel { throw URLError(.unknown) }
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel { throw URLError(.unknown) }
    func getAuthenticatedUser() throws -> AuthDataResultModel? { nil }
    func resetPassword(email: String) async throws {}
    func updatePassword(password: String) async throws {}
    func updateEmail(email: String) async throws {}
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel { throw URLError(.unknown) }
    func signOut() throws {}
}

private struct UnimplementedSessionValidator: SessionValidating {
    var isAuthenticated: Bool { false }
}

public struct EmptySecureStorage: SecureStorageProtocol {
    public init() {}
    public func save(data: Data, with key: String) async {}
    public func get(with key: String) async -> Data? { nil }
    public func delete(with key: String) async {}
}
