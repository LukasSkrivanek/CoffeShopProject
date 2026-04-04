//
//  AccountViewModel.swift
//  CoffeCore
//

import Foundation
import Dependencies

@Observable
public final class AccountViewModel {

    @ObservationIgnored
    @Dependency(\.userRepository)
    private var userRepository

    @ObservationIgnored
    @Dependency(\.authService)
    private var authService

    public var user: UserModel? { userRepository.user }

    public var name = ""
    public var address = ""
    public var mobile = ""
    public var email = ""

    public init() {}

    public func isInvalidForm() -> Bool {
        name.isEmpty || address.isEmpty || mobile.isEmpty
    }

    public func logOut() {
        do {
            try authService.signOut()
            userRepository.removeUser()
        } catch {
            print("Error signing out:", error.localizedDescription)
        }
    }
}
