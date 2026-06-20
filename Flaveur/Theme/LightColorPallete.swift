//
//  LightColorPallete.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

// MARK: - Light Theme Colors
struct LightColorPalette: ColorPalette {
    // Brand Colors (direct from Figma)
    let primary = Color(hex: "#4D6B62")      // Sweet Green
    let primaryLight = Color(hex: "#AABFB8") // Light Green
    let primaryDark = Color(hex: "#213D34")  // Green
    let accent = Color(hex: "#3E2823")       // Brown Pod
    
    // Background Colors
    let background = Color(hex: "#FFFDF9")    // Your White
    let surface = Color.white
    let elevated = Color.white.opacity(0.95)
    let seprator = Color(hex: "#D9D9D9")
    
    // Text Colors
    let textPrimary = Color(hex: "#1C0F0D")   // Your dark brown
    let textSecondary = Color(hex: "#3E2823") // Brown Pod (lighter)
    let textTertiary = Color(hex: "#4D6B62")  // Sweet Green
    let textOnPrimary = Color.white
    let textOnAccent = Color(hex: "#FFFDF9")  // Your White
    let textHeading = Color(hex: "#32201C") // Your light brown
    
    // UI Elements
    let divider = Color(hex: "#AABFB8").opacity(0.3)  // Light Green with opacity
    let overlay = Color.black.opacity(0.05)
    let disabled = Color.gray.opacity(0.5)
    let placeholder = Color(hex: "#AABFB8").opacity(0.5)
    
    // Status Colors (using your palette where appropriate)
    let success = Color(hex: "#4D6B62")       // Sweet Green
    let warning = Color.orange
    let error = Color.red
    let info = Color.blue
    
    // Recipe Tags (using your palette)
    let vegetarian = Color(hex: "#AABFB8")    // Light Green
    let vegan = Color(hex: "#4D6B62")         // Sweet Green
    let glutenFree = Color(hex: "#213D34")    // Green
    let spicy = Color(hex: "#3E2823")         // Brown Pod
}
