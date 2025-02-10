//
//  View + EXT.swift
//  Coffe
//
//  Created by macbook on 08.02.2025.
//
import SwiftUI

extension View {
    func styledButton(color: Color = .blue) -> some View {
        self
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(radius: 5)
            .padding(.horizontal)
            .contentShape(Rectangle())
    }
}
