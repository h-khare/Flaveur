//
//  CardStyleModifier.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

struct CardStyleModifier: ViewModifier {
    @Environment(\.theme) private var theme
    let style: CardStyle
    
    enum CardStyle {
        case elevated
        case outlined
        case filled
    }
    
    func body(content: Content) -> some View {
        content
            .background(background)
            .cornerRadius(theme.cornerRadius.card)
            .overlay(outline)
            .shadow(color: theme.shadows.recipeCard.color,
                   radius: theme.shadows.recipeCard.radius,
                   x: theme.shadows.recipeCard.x,
                   y: theme.shadows.recipeCard.y)
    }
    
    @ViewBuilder
    private var background: some View {
        switch style {
        case .elevated, .outlined:
            theme.colors.surface
        case .filled:
            theme.colors.background
        }
    }
    
    @ViewBuilder
    private var outline: some View {
        if style == .outlined {
            RoundedRectangle(cornerRadius: theme.cornerRadius.card)
                .stroke(theme.colors.divider, lineWidth: 1)
        }
    }
}
