//
//  DarkColorPalette.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

// MARK: - Dark Theme Colors
struct DarkColorPalette: ColorPalette {
    // Brand Colors (adjusted for dark mode but maintaining identity)
    let primary = Color(hex: "#4D6B62")       // Sweet Green - keep as accent
    let primaryLight = Color(hex: "#AABFB8")  // Light Green
    let primaryDark = Color(hex: "#213D34")   // Green
    let accent = Color(hex: "#3E2823")        // Brown Pod
    
    // Background Colors
    let background = Color(hex: "#1C0F0D")    // Your dark brown for dark mode
    let surface = Color(hex: "#2A2A2A")
    let elevated = Color(hex: "#333333")
    let seprator = Color(hex: "#D9D9D9")
    
    // Text Colors (inverted for dark mode)
    let textPrimary = Color(hex: "#FFFDF9")   // Your White
    let textSecondary = Color(hex: "#AABFB8") // Light Green
    let textTertiary = Color(hex: "#AABFB8").opacity(0.7)
    let textOnPrimary = Color(hex: "#1C0F0D") // Dark brown
    let textOnAccent = Color(hex: "#FFFDF9")  // White
    let textHeading = Color(hex: "#32201C") // Your light Brown
    
    // UI Elements
    let divider = Color(hex: "#AABFB8").opacity(0.2)
    let overlay = Color.white.opacity(0.05)
    let disabled = Color.gray.opacity(0.3)
    let placeholder = Color(hex: "#AABFB8").opacity(0.3)
    
    // Status Colors
    let success = Color(hex: "#4D6B62")       // Sweet Green
    let warning = Color.orange
    let error = Color.red.opacity(0.9)
    let info = Color.blue.opacity(0.9)
    
    // Recipe Tags (adjusted for dark mode visibility)
    let vegetarian = Color(hex: "#AABFB8")    // Light Green
    let vegan = Color(hex: "#4D6B62")         // Sweet Green
    let glutenFree = Color(hex: "#213D34")    // Green
    let spicy = Color(hex: "#3E2823")         // Brown Pod
}
