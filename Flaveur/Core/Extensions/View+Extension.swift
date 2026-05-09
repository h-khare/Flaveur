//
//  View+Extension.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI
extension View {
    func cardStyle(_ style: CardStyleModifier.CardStyle = .elevated) -> some View {
        modifier(CardStyleModifier(style: style))
    }
}


// MARK: - Text Style Modifiers
extension View {
    func textStyle(_ style: FontStyle, color: Color? = nil) -> some View {
        self.modifier(TextStyleModifier(style: style, color: color))
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle { PrimaryButtonStyle() }
}
