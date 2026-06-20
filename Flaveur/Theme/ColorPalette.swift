//
//  ColorPalette.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

// MARK: - Color Palette Protocol
protocol ColorPalette {
    // Brand Colors (from Figma)
    var primary: Color { get }        // #4D6B62 - Sweet Green
    var primaryLight: Color { get }   // #AABFB8 - Light Green
    var primaryDark: Color { get }    // #213D34 - Green
    var accent: Color { get }         // #3E2823 - Brown Pod
    
    // Background Colors
    var background: Color { get }      // Light: #FFFDF9, Dark: #1C0F0D
    var surface: Color { get }         // Cards, sheets
    var elevated: Color { get }        // Modals, popovers
    var seprator: Color { get }        // Seprator #D9D9D9
    
    // Text Colors
    var textPrimary: Color { get }     // Light: #1C0F0D, Dark: #FFFDF9
    var textSecondary: Color { get }   // Light: #3E2823, Dark: #AABFB8
    var textTertiary: Color { get }    // Light: #4D6B62, Dark: #AABFB8
    var textOnPrimary: Color { get }   // Text on primary buttons
    var textOnAccent: Color { get }    // Text on accent elements
    var textHeading: Color { get }     // Light: # 32201C
    
    // UI Element Colors
    var divider: Color { get }
    var overlay: Color { get }
    var disabled: Color { get }
    var placeholder: Color { get }
    
    // Status Colors
    var success: Color { get }
    var warning: Color { get }
    var error: Color { get }
    var info: Color { get }
    
    // Recipe-specific (using your palette)
    var vegetarian: Color { get }      // #AABFB8
    var vegan: Color { get }           // #4D6B62
    var glutenFree: Color { get }      // #213D34
    var spicy: Color { get }           // #3E2823
}
