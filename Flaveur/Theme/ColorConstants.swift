//
//  ColorConstants.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

// MARK: - Static Color Constants (for previews and specific use cases)
enum ColorConstants {
    // Your original Figma colors as static constants
    static let offWhite = Color(hex: "#FFFDF9")
    static let lightGreen = Color(hex: "#AABFB8")
    static let sweetGreen = Color(hex: "#4D6B62")
    static let forestGreen = Color(hex: "#213D34")
    static let brownPod = Color(hex: "#3E2823")
    static let darkBrown = Color(hex: "#1C0F0D")
    static let pureBlack = Color(hex: "#000000")
    
    // Gradients using your palette
    static let primaryGradient = LinearGradient(
        colors: [sweetGreen, forestGreen],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let accentGradient = LinearGradient(
        colors: [brownPod, darkBrown],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let backgroundGradient = LinearGradient(
        colors: [offWhite, lightGreen.opacity(0.3)],
        startPoint: .top,
        endPoint: .bottom
    )
    
    // Semantic static colors (for cases where you need fixed colors regardless of theme)
    enum Static {
        static let success = sweetGreen
        static let error:Color = .red
        static let warning:Color = .orange
        static let info:Color = .blue
    }
}

// MARK: - SwiftUI Color Extension with Your Palette
extension Color {
    // Direct access to your palette colors (convenience for previews)
    static let offWhite = Color(hex: "#FFFDF9")
    static let lightGreen = Color(hex: "#AABFB8")
    static let sweetGreen = Color(hex: "#4D6B62")
    static let forestGreen = Color(hex: "#213D34")
    static let brownPod = Color(hex: "#3E2823")
    static let darkBrown = Color(hex: "#1C0F0D")
}
