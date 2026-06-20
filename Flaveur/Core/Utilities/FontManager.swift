//
//  FontManager.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

// MARK: - Font Family Enum
enum FontFamily {
    case poppins      // For headings, display text
    case leagueSpartan // For body text, paragraphs
    
    var name: String {
        switch self {
        case .poppins: return "Poppins"
        case .leagueSpartan: return "LeagueSpartan" // Adjust based on actual font file name
        }
    }
    
    // Get the exact font name for a specific weight
    func fontName(for weight: FontWeight) -> String {
        switch self {
        case .poppins:
            switch weight {
            case .thin: return "Poppins-Thin"
            case .extraLight: return "Poppins-ExtraLight"
            case .light: return "Poppins-Light"
            case .regular: return "Poppins-Regular"
            case .medium: return "Poppins-Medium"
            case .semiBold: return "Poppins-SemiBold"
            case .bold: return "Poppins-Bold"
            case .extraBold: return "Poppins-ExtraBold"
            case .black: return "Poppins-Black"
            }
            
        case .leagueSpartan:
            switch weight {
            case .thin: return "LeagueSpartan-Thin"
            case .extraLight: return "LeagueSpartan-ExtraLight"
            case .light: return "LeagueSpartan-Light"
            case .regular: return "LeagueSpartan-Regular"
            case .medium: return "LeagueSpartan-Medium"
            case .semiBold: return "LeagueSpartan-SemiBold"
            case .bold: return "LeagueSpartan-Bold"
            case .extraBold: return "LeagueSpartan-ExtraBold"
            case .black: return "LeagueSpartan-Black"
            }
        }
    }
}

// MARK: - Font Weight Enum
enum FontWeight: String, CaseIterable {
    case thin = "Thin"
    case extraLight = "ExtraLight"
    case light = "Light"
    case regular = "Regular"
    case medium = "Medium"
    case semiBold = "SemiBold"
    case bold = "Bold"
    case extraBold = "ExtraBold"
    case black = "Black"
    
    var swiftUIWeight: Font.Weight {
        switch self {
        case .thin: return .thin
        case .extraLight: return .ultraLight
        case .light: return .light
        case .regular: return .regular
        case .medium: return .medium
        case .semiBold: return .semibold
        case .bold: return .bold
        case .extraBold: return .heavy
        case .black: return .black
        }
    }
}

// MARK: - Font Manager
enum FontManager {
    static func font(family: FontFamily, weight: FontWeight, size: CGFloat) -> Font {
        let fontName = family.fontName(for: weight)
        
        #if DEBUG
        if UIFont(name: fontName, size: size) == nil {
            print("⚠️ Font not found: \(fontName)")
        }
        #endif
        
        return Font.custom(fontName, size: size)
    }
    
    static func uiFont(family: FontFamily, weight: FontWeight, size: CGFloat) -> UIFont {
        let fontName = family.fontName(for: weight)
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
