//
//  LoginMethodSelectionView.swift
//  Coffe
//
//  Created by macbook on 01.02.2025.
//
import SwiftUI

struct LoginMethodSelectionView: View {
    var onMethodSelected: (LoginMethod) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select Login Method")
                .font(.title2)
                .bold()
            
            Button("Login with Email") {
                onMethodSelected(.email)
            }
            .styledButton(color: .mint)
            
            Button("Login with Google") {
                onMethodSelected(.google)
            }
            .styledButton(color: .blue)
        }
        .padding()
    }
}
