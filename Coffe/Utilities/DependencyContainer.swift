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
        container.register(BasketViewModel.self) { _ in BasketViewModel() }.inObjectScope(.container)
        container.register(UserRepository.self) { _ in UserRepository() }.inObjectScope(.container)
        container.register(HomeViewModel.self) { _ in HomeViewModel() }.inObjectScope(.container)
        container.register(AccountViewModel.self) { _ in AccountViewModel() }.inObjectScope(.container)
        container.register(LoginMethodSelectionViewModel.self) { _ in LoginMethodSelectionViewModel()}.inObjectScope(.container)
    
    }

    func resolve<T>(_ type: T.Type) -> T {
        guard let dependency = container.resolve(type) else {
            fatalError("Dependency for \(type) not found. Check Swinject registrations.")
        }
        return dependency
    }

}
