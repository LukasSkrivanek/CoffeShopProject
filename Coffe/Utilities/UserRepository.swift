//
//  UserRepository.swift
//  Coffe
//
//  Created by macbook on 27.02.2024.
//
import Foundation
import Observation

@Observable
final class UserRepository {
    private let secureStorage = SecureStorage()
    
    var user: UserModel?
    init() {
        Task{
            user = await loadUser()
        }
    }
    @MainActor
        private func loadUser() async -> UserModel? {
            return await fetchUser()
        }

    
    func saveChanges(name: String, address: String, mobile: String, email: String){
        if user != nil {
            updateUser(name: name, address: address, mobile: mobile, email: email)
        }else {
            createUser(name: name, address: address, mobile: mobile, email: email)
        }
    }
    func createUser(name: String, address: String, mobile: String, email: String){
        do {
            user = UserModel(id: UUID().uuidString, name: name, email: email, address: address, mobile: mobile)
            let userData = try JSONEncoder().encode(user)
            Task{
                await secureStorage.save(data: userData, with: userKey)
            }
        } catch{
            print("Error, Couldn't create user!")
        }
    }
    private func updateUser(name: String, address: String, mobile: String , email: String){
        do {
            user?.name = name
            user?.mobile = mobile
            user?.address = address
            user?.email = email
            let userData = try JSONEncoder().encode(user)
            Task{
                await secureStorage.save(data: userData, with: userKey)
            }
        } catch{
            print("Error, Couldn't save user!")
        }
    }
     func fetchUser() async -> UserModel? {
        guard let userData = await secureStorage.get(with: userKey) else {return nil}
        do {
            return try JSONDecoder().decode(UserModel.self, from: userData)
        } catch  {
            print("Error couldn't get user ")
        }
        return nil
    }
    func removeUser(){
        Task{
            await secureStorage.delete(with: userKey)
            user = nil
        }
    }
    
}
