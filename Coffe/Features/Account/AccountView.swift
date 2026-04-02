//
//  AccountView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//
import SwiftUI
import Dependencies

struct AccountView: View {
    @Environment(Coordinator.self)
    private var coordinator

    @Environment(AppState.self)
    private var appState

    @Environment(AppearanceState.self)
    private var appearanceState

    @State
    private var viewModel = AccountViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Picker("Appearance", selection: Bindable(appearanceState).mode) {
                    ForEach(AppearanceMode.allCases, id: \.self) { mode in
                        Text(mode.label).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                .tint(.brown)
                if let user = viewModel.userRepository.user, appState.isSignedIn {
                    UserInfoView(user: user, logOutAction: logOut)
                } else {
                    AuthButtonsView(
                        onLogin: { coordinator.presentSheet(.loginMethod, detent: .fraction(0.35)) },
                        onRegister: { coordinator.presentSheet(.registration, detent: .medium) }
                    )
                }
            }
            .padding(.bottom, 30)
        }
        .background(Color(UIColor.systemGroupedBackground))
    }

    private func logOut() {
        viewModel.logOut()
        appState.isSignedIn = false
    }
}
