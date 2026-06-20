//
//  SpacingPalette.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI
// MARK: - Spacing Palette
struct SpacingPalette {
    // Base units
    let xxxSmall: CGFloat = 2
    let xxSmall: CGFloat = 4
    let xSmall: CGFloat = 8
    let small: CGFloat = 12
    let medium: CGFloat = 16
    let large: CGFloat = 20
    let xLarge: CGFloat = 24
    let xxLarge: CGFloat = 32
    let xxxLarge: CGFloat = 40
    let huge: CGFloat = 48
    let massive: CGFloat = 64
    
    // Semantic spacing
    var padding: CGFloat { medium }
    var paddingSmall: CGFloat { small }
    var paddingLarge: CGFloat { large }
    
    var margin: CGFloat { large }
    var marginSmall: CGFloat { medium }
    
    var cornerRadius: CGFloat { 12 }
    var cornerRadiusSmall: CGFloat { 8 }
    var cornerRadiusLarge: CGFloat { 16 }
    
    var iconSize: CGFloat { 24 }
    var iconSizeSmall: CGFloat { 16 }
    var iconSizeLarge: CGFloat { 32 }
    
    var avatarSize: CGFloat { 40 }
    var avatarSizeSmall: CGFloat { 32 }
    var avatarSizeLarge: CGFloat { 56 }
    
    var cardSpacing: CGFloat { 16 }
    var sectionSpacing: CGFloat { 24 }
    var listSpacing: CGFloat { 12 }
}

// MARK: - Corner Radius Palette
struct CornerRadiusPalette {
    let none: CGFloat = 0
    let extraSmall: CGFloat = 4
    let small: CGFloat = 8
    let medium: CGFloat = 12
    let large: CGFloat = 16
    let extraLarge: CGFloat = 24
    let circular: CGFloat = .infinity
    
    // Component-specific
    var button: CGFloat { medium }
    var card: CGFloat { large }
    var image: CGFloat { small }
    var input: CGFloat { small }
    var modal: CGFloat { large }
}

// MARK: - Shadow Palette
struct ShadowPalette {
    let elevation1 = Shadow(
        color: .black.opacity(0.1),
        radius: 2,
        x: 0,
        y: 1
    )
    
    let elevation2 = Shadow(
        color: .black.opacity(0.15),
        radius: 4,
        x: 0,
        y: 2
    )
    
    let elevation3 = Shadow(
        color: .black.opacity(0.2),
        radius: 8,
        x: 0,
        y: 4
    )
    
    let elevation4 = Shadow(
        color: .black.opacity(0.25),
        radius: 12,
        x: 0,
        y: 6
    )
    
    // Recipe card specific
    var recipeCard: Shadow { elevation2 }
    var modal: Shadow { elevation4 }
    var button: Shadow { elevation1 }
    var pressed: Shadow { Shadow(color: .clear, radius: 0, x: 0, y: 0) }
}

struct Shadow {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
}
