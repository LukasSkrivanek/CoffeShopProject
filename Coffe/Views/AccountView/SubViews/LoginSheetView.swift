//
//  LoginSheetView.swift
//  Coffe
//
//  Created by macbook on 10.02.2025.
//
import SwiftUI

struct LoginSheetView: View {
    @Environment(Coordinator.self) private var coordinator
    @Environment(AppState.self) private var appState
    @Environment(UserRepository.self) private var userRepository
    @Environment(AccountViewModel.self) private var accountViewModel

    @State private var loginViewModel =  LoginViewModel()

   

    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.title2)
                .bold()

            TextField("Email", text: $loginViewModel.email)
                .textFieldStyle()
                .autocapitalization(.none)
                .keyboardType(.emailAddress)

            SecureField("Password", text: $loginViewModel.password)
                .textFieldStyle()

            Button {
                Task {
                    await loginViewModel.loginUser(userRepository: userRepository)
                    appState.isSignedIn = true
                    accountViewModel.setup(user: userRepository.user)
                    coordinator.dismissSheet()
                }
            } label: {
                Text("Login")
                    .styledButton(color: .brown)
            }

            Button {
                coordinator.dismissSheet()
            } label: {
                Text("Cancel")
                    .styledButton(color: .red)
            }
        }
        .padding()
    }
}


@Observable
class LoginViewModel {
    var email: String = ""
    var password: String = ""
    var errorMessage: String?

    func loginUser(userRepository: UserRepository) async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password cannot be empty"
            return
        }

        do {
            let authUser = try await AuthenticationManager.shared.signInUser(email: email, password: password)
            let userModel = UserModel(id: authUser.user.uid, name: "Lukas", email: authUser.user.email ?? "", address: "", mobile: "")

            await MainActor.run {
                userRepository.user = userModel
            
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
            }
        }
    }
}
