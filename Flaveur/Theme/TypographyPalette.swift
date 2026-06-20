//
//  TypographyPalette.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

// MARK: - Typography Palette
struct TypographyPalette {
    // MARK: - Display/Heading Styles (Using Poppins)
    let displayLarge: FontStyle      // Poppins Light 57
    let displayMedium: FontStyle     // Poppins Light 45
    let displaySmall: FontStyle      // Poppins Regular 36
    
    let headlineLarge: FontStyle     // Poppins Bold 32
    let headlineMedium: FontStyle    // Poppins Bold 28
    let headlineSmall: FontStyle     // Poppins SemiBold 24
    
    let titleLarge: FontStyle        // Poppins SemiBold 22
    let titleMedium: FontStyle       // Poppins SemiBold 18
    let titleSmall: FontStyle        // Poppins Medium 16
    let titleHeading: FontStyle        // Poppins Medium 14
    
    // MARK: - Body Text Styles (Using League Spartan)
    let bodyLarge: FontStyle         // League Spartan Regular 16
    let bodyMedium: FontStyle        // League Spartan Regular 14
    let bodySmall: FontStyle         // League Spartan Regular 12
    
    let titleXtraSmall: FontStyle    // League Spartan SemiBold 14
//    let textHeading: FontStyle       // Poppins Medium 15
    
    let labelLarge: FontStyle        // League Spartan Medium 15
    let labelMedium: FontStyle       // League Spartan Medium 13
    let labelRegular: FontStyle      // League Poppins Regular 13
    let labelSmall: FontStyle        // League Spartan Medium 11
    
    // MARK: - Recipe-specific (Mix of both families)
    let recipeTitle: FontStyle       // Poppins SemiBold 20
    let recipeDescription: FontStyle // League Spartan Regular 14
    let ingredientName: FontStyle    // League Spartan Regular 16
    let instructionStep: FontStyle   // League Spartan Light 15 (with serif?)
    let chefName: FontStyle          // League Spartan Medium 15
    let cookingTime: FontStyle       // League Spartan Light 13
    
    init() {
        // MARK: - Poppins Styles (Headings)
        self.displayLarge = FontStyle(family: .poppins, weight: .light, size: 57)
        self.displayMedium = FontStyle(family: .poppins, weight: .light, size: 45)
        self.displaySmall = FontStyle(family: .poppins, weight: .regular, size: 36)
        
        self.headlineLarge = FontStyle(family: .poppins, weight: .bold, size: 32)
        self.headlineMedium = FontStyle(family: .poppins, weight: .bold, size: 28)
        self.headlineSmall = FontStyle(family: .poppins, weight: .semiBold, size: 25)
        
        self.titleLarge = FontStyle(family: .poppins, weight: .semiBold, size: 22)
        self.titleMedium = FontStyle(family: .poppins, weight: .semiBold, size: 18)
        self.titleSmall = FontStyle(family: .poppins, weight: .medium, size: 16)
        self.titleHeading = FontStyle(family: .poppins, weight: .semiBold, size: 14)
        self.titleXtraSmall = FontStyle(family: .leagueSpartan, weight: .semiBold, size: 14)
        
        // MARK: - League Spartan Styles (Body)
        self.bodyLarge = FontStyle(family: .leagueSpartan, weight: .regular, size: 16)
        self.bodyMedium = FontStyle(family: .leagueSpartan, weight: .regular, size: 14)
        self.bodySmall = FontStyle(family: .leagueSpartan, weight: .regular, size: 12)
        
        self.labelLarge = FontStyle(family: .leagueSpartan, weight: .medium, size: 15)
        self.labelMedium = FontStyle(family: .leagueSpartan, weight: .medium, size: 13)
        self.labelRegular = FontStyle(family: .poppins, weight: .regular, size: 13)
        self.labelSmall = FontStyle(family: .leagueSpartan, weight: .medium, size: 11)
        
        // MARK: - Recipe-specific
        self.recipeTitle = FontStyle(family: .poppins, weight: .semiBold, size: 20)
        self.recipeDescription = FontStyle(family: .leagueSpartan, weight: .regular, size: 14, lineSpacing: 4)
        self.ingredientName = FontStyle(family: .leagueSpartan, weight: .regular, size: 16)
        self.instructionStep = FontStyle(family: .leagueSpartan, weight: .light, size: 15, lineSpacing: 6)
        self.chefName = FontStyle(family: .leagueSpartan, weight: .medium, size: 15)
        self.cookingTime = FontStyle(family: .leagueSpartan, weight: .light, size: 13)
    }
}

enum AppTextStyle:Hashable {
    // Poppins (Headings)
    case displayLarge
    case displayMedium
    case displaySmall
    case headlineLarge
    case headlineMedium
    case headlineSmall
    case titleLarge
    case titleMedium
    case titleSmall
    case titleHeading
    
    // League Spartan (Body)
    case bodyLarge
    case bodyMedium
    case bodySmall
    case labelLarge
    case labelMedium
    case labelRegular
    case labelSmall
    case titleXtraSmall
    
    // Recipe-specific
    case recipeTitle
    case recipeDescription
    case ingredientName
    case instructionStep
    case chefName
    case cookingTime
    
    
    // Custom
    case custom(family: FontFamily, weight: FontWeight, size: CGFloat)
}

extension TypographyPalette {
    func style(for textStyle: AppTextStyle) -> FontStyle {
        switch textStyle {
        // Poppins styles
        case .displayLarge: return displayLarge
        case .displayMedium: return displayMedium
        case .displaySmall: return displaySmall
        case .headlineLarge: return headlineLarge
        case .headlineMedium: return headlineMedium
        case .headlineSmall: return headlineSmall
        case .titleLarge: return titleLarge
        case .titleMedium: return titleMedium
        case .titleSmall: return titleSmall
        case .titleHeading: return titleHeading
        
        // League Spartan styles
        case .bodyLarge: return bodyLarge
        case .bodyMedium: return bodyMedium
        case .bodySmall: return bodySmall
        case .labelLarge: return labelLarge
        case .labelMedium: return labelMedium
        case .labelRegular: return labelRegular
        case .labelSmall: return labelSmall
        case .titleXtraSmall: return titleXtraSmall
        
        // Recipe-specific
        case .recipeTitle: return recipeTitle
        case .recipeDescription: return recipeDescription
        case .ingredientName: return ingredientName
        case .instructionStep: return instructionStep
        case .chefName: return chefName
        case .cookingTime: return cookingTime
        
        // Custom
        case .custom(let family, let weight, let size):
            return FontStyle(family: family, weight: weight, size: size)
        }
    }
}
