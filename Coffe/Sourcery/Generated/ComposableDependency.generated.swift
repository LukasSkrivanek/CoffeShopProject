// Generated using Sourcery 2.3.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// Generated using Sourcery
import Dependencies

// MARK: - SecureStorage

extension SecureStorage: DependencyKey {
    static var liveValue: SecureStorage { SecureStorage() }
}

extension DependencyValues {
    var secureStorage: SecureStorage {
        get { self[SecureStorage.self] }
        set { self[SecureStorage.self] = newValue }
    }
}
