//
//  LoginMethodSelectionViewModel.swift
//  CoffeCore
//

import Foundation
import Dependencies

@Observable
public final class LoginMethodSelectionViewModel {

    @ObservationIgnored
    @Dependency(\.authService)
    private var authService

    @ObservationIgnored
    @Dependency(\.userRepository)
    private var userRepository

    public var selectedMethod: LoginMethod?
    public var alert: CoreAlert?

    public init() {}

    public func selectMethod(_ method: LoginMethod) {
        selectedMethod = method
    }

    // Google tokens are resolved in the iOS layer (SignInGoogleHelper)
    // and passed here — no GoogleSignIn SDK needed in CoffeCore
    
    public func signInWithGoogle(tokens: GoogleSignInResultModel) async throws {
        _ = try await authService.signInWithGoogle(tokens: tokens)
        userRepository.saveChanges(
            name: tokens.name ?? "",
            address: "",
            mobile: "",
            email: tokens.email ?? ""
        )
    }
}
