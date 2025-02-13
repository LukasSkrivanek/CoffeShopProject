//
//  DependencyContainer.swift
//  Coffe
//
//  Created by macbook on 30.01.2025.
//
import Swinject

class DependencyContainer {
    static let shared = DependencyContainer()
    let container: Container

    private init() {
        container = Container()
        
        // 🔹 Repositories
        container.register(FirebaseRepository.self) { _ in FirebaseRepository() }.inObjectScope(.container)
        container.register(UserRepository.self) { _ in UserRepository() }.inObjectScope(.container)

        // 🔹 ViewModels
        container.register(HomeViewModel.self) { r in
            HomeViewModel(firebaseRepository: r.resolve(FirebaseRepository.self)!)
        }.inObjectScope(.container)
        container.register(LoginViewModel.self) { r in
            LoginViewModel(userRepository: r.resolve(UserRepository.self)!) }.inObjectScope(.container)

        container.register(BasketViewModel.self) { r in BasketViewModel(userRepository: r.resolve(UserRepository.self)!, firebaseRepository: r.resolve(FirebaseRepository.self)!) }.inObjectScope(.container)
        container.register(AccountViewModel.self) { r in AccountViewModel(userRepository: r.resolve(UserRepository.self)!) }.inObjectScope(.container)
        container.register(LoginMethodSelectionViewModel.self) { r in LoginMethodSelectionViewModel(userRepository: r.resolve(UserRepository.self)!)
            }.inObjectScope(.container)
        container.register(RegistrationViewModel.self) { r in
            RegistrationViewModel(userRepository: r.resolve(UserRepository.self)!)
        }

        // 🔹 GlobalStates
        container.register(AppState.self) { _ in
            MainActor.assumeIsolated {
                AppState()
            }
        }.inObjectScope(.container)
    }

    static func resolve<T>(_ type: T.Type) -> T {
        guard let dependency = shared.container.resolve(type) else {
            fatalError("Dependency for \(type) not found. Check Swinject registrations.")
        }
        return dependency
    }
}
