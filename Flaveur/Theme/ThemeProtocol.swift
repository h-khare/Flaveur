//
//  ThemeProtocol.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

// MARK: - Core Theme Protocol
protocol AppTheme {
    var colors: ColorPalette { get }
    var typography: TypographyPalette { get }
    var spacing: SpacingPalette { get }
    var cornerRadius: CornerRadiusPalette { get }
    var shadows: ShadowPalette { get }
//    var animations: AnimationPalette { get } // Uncomment this
}

// MARK: - Add AnimationPalette
struct AnimationPalette {
    let buttonPress: Animation = .easeInOut(duration: 0.2)
    let screenTransition: Animation = .easeInOut(duration: 0.3)
    let cardAppear: Animation = .spring(response: 0.6, dampingFraction: 0.8)
    let loadingSpinner: Animation = .linear(duration: 1.0).repeatForever(autoreverses: false)
}

// MARK: - Theme Implementation
struct LightTheme: AppTheme {
    let colors = LightColorPalette() as ColorPalette
    let typography = TypographyPalette()
    let spacing = SpacingPalette()
    let cornerRadius = CornerRadiusPalette()
    let shadows = ShadowPalette()
//    let animations = AnimationPalette() // Uncomment this
}

struct DarkTheme: AppTheme {
    let colors = DarkColorPalette() as ColorPalette
    let typography = TypographyPalette()
    let spacing = SpacingPalette()
    let cornerRadius = CornerRadiusPalette()
    let shadows = ShadowPalette()
//    let animations = AnimationPalette() // Uncomment this
}
