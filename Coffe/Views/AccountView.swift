//
//  AccountView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//
import SwiftUI
import GoogleSignInSwift

struct AccountView: View {
    @Environment(UserRepository.self) private var userRepository
    @Environment(AccountViewModel.self) private var accountViewModel
    @Environment(AuthenticationViewModel.self) private var authenticationViewModel
    @Binding var isSignedIn: Bool
    @Environment(\.colorScheme) var colorScheme // Access the current color scheme

    @State private var isDarkMode: Bool = false // Track mode toggle
    
    var body: some View {
        @Bindable var accountViewModel = accountViewModel
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Personal Info Section
                    Section(header: Text("Personal Info")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.primary)
                        .padding(.top, 20)
                    ) {
                        TextField("First Name", text: $accountViewModel.name)
                            .textFieldStyle()
                        TextField("Address", text: $accountViewModel.address)
                            .textFieldStyle()
                        TextField("Mobile", text: $accountViewModel.mobile)
                            .keyboardType(.phonePad)
                            .textFieldStyle()
                    }
                    
                    // Update or Create Button
                    Section {
                        Button {
                            // save user details
                            userRepository.saveChanges(name: accountViewModel.name, address: accountViewModel.address, mobile: accountViewModel.mobile, email: accountViewModel.email)
                        } label: {
                            Text(userRepository.user != nil ? "Update" : "Create")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal)
                    .disabled(accountViewModel.isInvalidForm())
                    
                    // Google Sign In Button
                    Section {
                        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                            Task {
                                do {
                                    try await authenticationViewModel.signInGoogle()
                                    userRepository.user = await userRepository.fetchUser()
                                    accountViewModel.setup(user: userRepository.user)
                                } catch {
                                    print(error)
                                }
                            }
                        }
                    }

                    // Dark Mode Toggle Button
                    Section {
                        Button(action: {
                            // Switch the color scheme manually
                            isDarkMode.toggle()
                            UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
                        }) {
                            Text("Switch to \(isDarkMode ? "Light" : "Dark") Mode")
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.primary)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal)
                    
                }
                .padding(.bottom, 30)
            }
        
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(UIColor.systemGroupedBackground))
            .cornerRadius(25)
            .shadow(radius: 10)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    if userRepository.user != nil { logOutButton() }
                }
            }
            .onAppear {
                accountViewModel.setup(user: userRepository.user)
            }
            .onChange(of: userRepository.user, initial: false) { oldUser, newUser in
                if oldUser != newUser {
                    accountViewModel.setup(user: newUser)
                }
            }
        }
    }

    private func logOutButton() -> some View {
        Button {
            userRepository.removeUser()
            accountViewModel.setup(user: nil)
            isSignedIn.toggle()
        } label: {
            Text("Log Out")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .cornerRadius(12)
                .shadow(radius: 5)
        }
        .padding(.horizontal)
    }
}

#Preview {
    AccountView(isSignedIn: .constant(true))
        .environment(DependencyContainer.shared.resolve(UserRepository.self))
}
