//
//  TextFieldStyleModifier.swift
//  Coffe
//
//  Created by macbook on 01.02.2025.
//

import SwiftUI

struct TextFieldStyleModifier: ViewModifier {
    var paddingAmount: CGFloat
    var borderColor: Color

    func body(content: Content) -> some View {
        content
            .padding(paddingAmount)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(borderColor.opacity(0.3), lineWidth: 1)
            )
            .padding(.horizontal)
    }
}

extension View {
    func textFieldStyle(paddingAmount: CGFloat = 15, borderColor: Color = .gray) -> some View {
        self.modifier(TextFieldStyleModifier(paddingAmount: paddingAmount, borderColor: borderColor))
    }
}
