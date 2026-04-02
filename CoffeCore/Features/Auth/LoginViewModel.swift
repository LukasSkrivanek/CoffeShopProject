//
//  LoginViewModel.swift
//  CoffeCore
//

import Foundation
import Dependencies

@Observable
public final class LoginViewModel {

    @ObservationIgnored
    @Dependency(\.userRepository)
    private var userRepository

    @ObservationIgnored
    @Dependency(\.authService)
    private var authService

    public var email: String = ""
    public var password: String = ""
    public var alert: CoreAlert?

    public init() {}

    public func loginUser() async -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            await MainActor.run {
                alert = CoreAlert(title: "Error", subtitle: "Email and password cannot be empty")
            }
            return false
        }
        do {
            let authUser = try await authService.signInUser(email: email, password: password)
            let userModel = UserModel(
                id: authUser.uid,
                name: "",
                email: authUser.email ?? "",
                address: "",
                mobile: ""
            )
            await MainActor.run {
                userRepository.user = userModel
            }
            return true
        } catch {
            await MainActor.run {
                alert = CoreAlert(title: "Error", subtitle: error.localizedDescription)
            }
            return false
        }
    }
}
