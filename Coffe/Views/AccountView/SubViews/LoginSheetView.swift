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
    
    @State private var loginViewModel = LoginViewModel(userRepository: UserRepository()) // Předpokládám, že máte ViewModel pro přihlášení
    
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
                    await loginViewModel.loginUser()
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

    private var userRepository: UserRepository

    // Inicializace s předáním UserRepository
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func loginUser() async {
        // Prověřte, zda jsou email a heslo zadány
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password cannot be empty"
            return
        }

        do {
            // Přihlášení uživatele pomocí AuthenticationManager
            try await AuthenticationManager.shared.signInUser(email: email, password: password)
            // Po přihlášení si načteme uživatelská data
            userRepository.user = await userRepository.fetchUser()
        } catch {
            // Pokud dojde k chybě, zobrazí se chybová zpráva
            errorMessage = error.localizedDescription
        }
    }
}
