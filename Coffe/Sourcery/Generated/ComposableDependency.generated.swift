// Generated using Sourcery 2.3.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// Generated using Sourcery
import Dependencies

// MARK: - AccountViewModel

extension AccountViewModel: DependencyKey {
    static var liveValue: AccountViewModel { AccountViewModel() }
}

extension DependencyValues {
    var accountViewModel: AccountViewModel {
        get { self[AccountViewModel.self] }
        set { self[AccountViewModel.self] = newValue }
    }
}
// MARK: - AuthenticationManager

extension AuthenticationManager: DependencyKey {
    static var liveValue: AuthenticationManager { AuthenticationManager() }
}

extension DependencyValues {
    var authenticationManager: AuthenticationManager {
        get { self[AuthenticationManager.self] }
        set { self[AuthenticationManager.self] = newValue }
    }
}
// MARK: - BasketViewModel

extension BasketViewModel: DependencyKey {
    static var liveValue: BasketViewModel { BasketViewModel() }
}

extension DependencyValues {
    var basketViewModel: BasketViewModel {
        get { self[BasketViewModel.self] }
        set { self[BasketViewModel.self] = newValue }
    }
}
// MARK: - DrinkListViewModel

extension DrinkListViewModel: DependencyKey {
    static var liveValue: DrinkListViewModel { DrinkListViewModel() }
}

extension DependencyValues {
    var drinkListViewModel: DrinkListViewModel {
        get { self[DrinkListViewModel.self] }
        set { self[DrinkListViewModel.self] = newValue }
    }
}
// MARK: - FirebaseAuthServiceAdapter

extension FirebaseAuthServiceAdapter: DependencyKey {
    static var liveValue: FirebaseAuthServiceAdapter { FirebaseAuthServiceAdapter() }
}

extension DependencyValues {
    var firebaseAuthServiceAdapter: FirebaseAuthServiceAdapter {
        get { self[FirebaseAuthServiceAdapter.self] }
        set { self[FirebaseAuthServiceAdapter.self] = newValue }
    }
}
// MARK: - FirebaseRepository

extension FirebaseRepository: DependencyKey {
    static var liveValue: FirebaseRepository { FirebaseRepository() }
}

extension DependencyValues {
    var firebaseRepository: FirebaseRepository {
        get { self[FirebaseRepository.self] }
        set { self[FirebaseRepository.self] = newValue }
    }
}
// MARK: - LoginMethodSelectionViewModel

extension LoginMethodSelectionViewModel: DependencyKey {
    static var liveValue: LoginMethodSelectionViewModel { LoginMethodSelectionViewModel() }
}

extension DependencyValues {
    var loginMethodSelectionViewModel: LoginMethodSelectionViewModel {
        get { self[LoginMethodSelectionViewModel.self] }
        set { self[LoginMethodSelectionViewModel.self] = newValue }
    }
}
// MARK: - LoginViewModel

extension LoginViewModel: DependencyKey {
    static var liveValue: LoginViewModel { LoginViewModel() }
}

extension DependencyValues {
    var loginViewModel: LoginViewModel {
        get { self[LoginViewModel.self] }
        set { self[LoginViewModel.self] = newValue }
    }
}
// MARK: - RegistrationViewModel

extension RegistrationViewModel: DependencyKey {
    static var liveValue: RegistrationViewModel { RegistrationViewModel() }
}

extension DependencyValues {
    var registrationViewModel: RegistrationViewModel {
        get { self[RegistrationViewModel.self] }
        set { self[RegistrationViewModel.self] = newValue }
    }
}
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
// MARK: - UserRepository

extension UserRepository: DependencyKey {
    static var liveValue: UserRepository { UserRepository() }
}

extension DependencyValues {
    var userRepository: UserRepository {
        get { self[UserRepository.self] }
        set { self[UserRepository.self] = newValue }
    }
}
