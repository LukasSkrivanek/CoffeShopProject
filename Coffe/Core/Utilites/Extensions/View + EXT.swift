//
//  View + EXT.swift
//  Coffe
//
//  Created by macbook on 08.02.2025.
//
import SwiftUI

extension View {
    func styledButton(usedColor: Color = .blue) -> some View {
        self
            .frame(maxWidth: .infinity)
            .padding()
            .background(usedColor)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(radius: 5)
            .padding(.horizontal)
            .contentShape(Rectangle())
    }
}
