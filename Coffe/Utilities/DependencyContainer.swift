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
        container.register(UserRepository.self) { r in UserRepository(secureStorage: r.resolve(SecureStorage.self)!) }.inObjectScope(.container)
        
        
        
        // 🔹 Managers
        container.register(AuthServiceProtocol.self) { _ in
            FirebaseAuthServiceAdapter()
        }.inObjectScope(.container)

        container.register(AuthenticationManager.self) { r in
            AuthenticationManager(authServiceProtocol: r.resolve(AuthServiceProtocol.self)!)
        }.inObjectScope(.container)

        // 🔹 ViewModels
        container.register(HomeViewModel.self) { r in
            HomeViewModel(firebaseRepository: r.resolve(FirebaseRepository.self)!)
        }.inObjectScope(.container)
        container.register(LoginViewModel.self) { r in
            LoginViewModel(userRepository: r.resolve(UserRepository.self)!, authenticationManager: r.resolve(AuthenticationManager.self)!) }.inObjectScope(.container)

        container.register(BasketViewModel.self) { r in BasketViewModel(userRepository: r.resolve(UserRepository.self)!, firebaseRepository: r.resolve(FirebaseRepository.self)!) }.inObjectScope(.container)
        container.register(AccountViewModel.self) { r in AccountViewModel(userRepository: r.resolve(UserRepository.self)!, authenticationManager: r.resolve(AuthenticationManager.self)!) }.inObjectScope(.container)
        container.register(LoginMethodSelectionViewModel.self) { r in LoginMethodSelectionViewModel(userRepository: r.resolve(UserRepository.self)!, authenticationManager: r.resolve(AuthenticationManager.self)!)
            }.inObjectScope(.container)
        container.register(RegistrationViewModel.self) { r in
            RegistrationViewModel(userRepository: r.resolve(UserRepository.self)!, authenticationManager: r.resolve(AuthenticationManager.self)!)
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
            }
        }.inObjectScope(.container)
        
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
