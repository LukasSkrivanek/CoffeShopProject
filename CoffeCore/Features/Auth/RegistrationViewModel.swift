//
//  RegistrationViewModel.swift
//  CoffeCore
//

import Foundation
import Dependencies

@Observable
public final class RegistrationViewModel {

    @ObservationIgnored
    @Dependency(\.userRepository)
    private var userRepository

    @ObservationIgnored
    @Dependency(\.authService)
    private var authService

    public var email: String = ""
    public var password: String = ""
    public var confirmPassword: String = ""
    public var alert: CoreAlert?

    public init() {}

    public func registerUser() async {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            await MainActor.run {
                alert = CoreAlert(title: "Error", subtitle: "All fields are required")
            }
            return
        }
        guard password == confirmPassword else {
            await MainActor.run {
                alert = CoreAlert(title: "Error", subtitle: "Passwords do not match")
            }
            return
        }
        do {
            _ = try await authService.createUser(email: email, password: password)
            userRepository.user = await userRepository.fetchUser()
        } catch {
            await MainActor.run {
                alert = CoreAlert(title: "Error", subtitle: error.localizedDescription)
            }
        }
    }
}
