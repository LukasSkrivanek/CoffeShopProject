// Generated using Sourcery 2.3.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// Generated using Sourcery
import Dependencies

// MARK: - AuthenticationManager

private enum AuthenticationManagerKey: DependencyKey {
    static let liveValue: AuthenticationManager = AuthenticationManager()
}

extension DependencyValues {
    var authenticationManager: AuthenticationManager {
        get { self[AuthenticationManagerKey.self] }
        set { self[AuthenticationManagerKey.self] = newValue }
    }
}
// MARK: - FirebaseAuthServiceAdapter

private enum FirebaseAuthServiceAdapterKey: DependencyKey {
    static let liveValue: FirebaseAuthServiceAdapter = FirebaseAuthServiceAdapter()
}

extension DependencyValues {
    var firebaseAuthServiceAdapter: FirebaseAuthServiceAdapter {
        get { self[FirebaseAuthServiceAdapterKey.self] }
        set { self[FirebaseAuthServiceAdapterKey.self] = newValue }
    }
}
// MARK: - FirebaseRepository

private enum FirebaseRepositoryKey: DependencyKey {
    static let liveValue: FirebaseRepository = FirebaseRepository()
}

extension DependencyValues {
    var firebaseRepository: FirebaseRepository {
        get { self[FirebaseRepositoryKey.self] }
        set { self[FirebaseRepositoryKey.self] = newValue }
    }
}
// MARK: - SecureStorage

private enum SecureStorageKey: DependencyKey {
    static let liveValue: SecureStorage = SecureStorage()
}

extension DependencyValues {
    var secureStorage: SecureStorage {
        get { self[SecureStorageKey.self] }
        set { self[SecureStorageKey.self] = newValue }
    }
}
// MARK: - UserRepository

private enum UserRepositoryKey: DependencyKey {
    static let liveValue: UserRepository = UserRepository()
}

extension DependencyValues {
    var userRepository: UserRepository {
        get { self[UserRepositoryKey.self] }
        set { self[UserRepositoryKey.self] = newValue }
    }
}
