//
//  DependencyContainer.swift
//  Coffe
//
//  Created by macbook on 30.01.2025.
//
import Swinject
import SwiftUI

class DependencyContainer {
    static let shared = DependencyContainer()
    let container: Container

    private init() {
        container = Container()
        // 🔹 Repositories
        container.register(SecureStorage.self) { _ in SecureStorage() }.inObjectScope(.container)
        container.register(FirebaseRepository.self) { _ in FirebaseRepository() }.inObjectScope(.container)
        container.register(UserRepository.self) {resolve in
            UserRepository(secureStorage: resolve.resolve(SecureStorage.self)!) }.inObjectScope(.container)
        // 🔹 Managers
        container.register(AuthServiceProtocol.self) { _ in
            FirebaseAuthServiceAdapter()
        }.inObjectScope(.container)

        container.register(AuthenticationManager.self) { resolve in
            AuthenticationManager(authServiceProtocol: resolve.resolve(AuthServiceProtocol.self)!)
        }.inObjectScope(.container)
        // 🔹 ViewModels
        container.register(DrinkListViewModel.self) { resolve in
            DrinkListViewModel(firebaseRepository: resolve.resolve(FirebaseRepository.self)!)
        }.inObjectScope(.container)
        container.register(LoginViewModel.self) { resolve in
            LoginViewModel(userRepository: resolve.resolve(UserRepository.self)!,
                           authenticationManager: resolve.resolve(AuthenticationManager.self)!) }
        .inObjectScope(.container)
        container.register(BasketViewModel.self) { resolve in
            BasketViewModel(userRepository:
                                resolve.resolve(UserRepository.self)!,
                            firebaseRepository: resolve.resolve(FirebaseRepository.self)!) }
        .inObjectScope(.container)
        container.register(AccountViewModel.self) { resolve in
            AccountViewModel(userRepository: resolve.resolve(UserRepository.self)!,
                             authenticationManager: resolve.resolve(AuthenticationManager.self)!) }
        .inObjectScope(.container)
        container.register(LoginMethodSelectionViewModel.self) { resolve in
            LoginMethodSelectionViewModel(userRepository: resolve.resolve(UserRepository.self)!,
                                          authenticationManager: resolve.resolve(AuthenticationManager.self)!)
            }
        .inObjectScope(.container)
        container.register(RegistrationViewModel.self) { resolve in
            RegistrationViewModel(userRepository: resolve.resolve(UserRepository.self)!,
                                  authenticationManager: resolve.resolve(AuthenticationManager.self)!)
        }
        // GlobalStates
        container.register(AppState.self) { _ in
            MainActor.assumeIsolated {
                AppState()
            }
        }.inObjectScope(.container)
        container.register(IsDarkMode.self) { _ in
            MainActor.assumeIsolated {
                IsDarkMode()
            }}.inObjectScope(.container)        
        // Coordinator
        container.register(Coordinator.self) { _ in
            Coordinator()
        }.inObjectScope(.container)
    }

    static func resolve<T>(_ type: T.Type) -> T {
        guard let dependency = shared.container.resolve(type) else {
            fatalError("Dependency for \(type) not found. Check Swinject registrations.")
        }
        return dependency
    }
}
