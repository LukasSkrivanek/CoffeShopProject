//
//  MockUserRepository.swift
//  Coffe
//
//  Created by macbook on 20.03.2025.
//

import Foundation
@testable import Coffe

class MockUserRepository: UserRepositoryProtocol {
    var secureStorage: SecureStorageProtocol
    var user: UserModel?
    init(secureStorage: SecureStorageProtocol, user: UserModel? = nil) {
        self.secureStorage = secureStorage
        self.user = user
    }
    func loadUser() async -> UserModel? {
        return UserModel(
            id: UUID().uuidString,
            name: "Lukas",
            email: "kuky.skrivos@gmail.com",
            address: "Adress",
            mobile: "4303940394843"
        )
    }
    func saveUser() async {
        
    }
    
    func saveChanges(name: String, address: String, mobile: String, email: String) {
        
    }
    
    func createUser(name: String, address: String, mobile: String, email: String) {
        
    }
    
    func updateUser(name: String, address: String, mobile: String, email: String) {
        
    }
    
    func fetchUser() async -> UserModel? {
        return UserModel(
            id: UUID().uuidString,
            name: "Lukas",
            email: "kuky.skrivos@gmail.com",
            address: "Adress",
            mobile: "4303940394843"
        )
    }
    
    func removeUser() {
        
    }
    
    
}
