//
//  LoginMethodSelectionView.swift
//  Coffe
//
//  Created by macbook on 01.02.2025.
//
import SwiftUI

struct LoginMethodSelectionView: View {
    @Environment(Coordinator.self) private var
    @Environment(LoginMethodSelectionViewModel.self) private var loginMethodViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select Login Method")
                .font(.title2)
                .bold()
            
            Button("Login with Email") {
                loginMethodViewModel.selectedMethod = .email
              
            }
            .styledButton(color: .mint)
            
            Button("Login with Google") {
                loginMethodViewModel.selectedMethod = .google
            }
            .styledButton(color: .blue)
        }
        .padding()
    }
}
