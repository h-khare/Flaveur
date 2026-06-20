//
//  ImageConstants.swift
//  Flaveur
//
//  Created by mac on 09/03/26.
//

import SwiftUI

// MARK: - Type-Safe Image Enum
enum AppImage: String {
    // App Icons & Logos
    case appLogo = "app-logo"
    case appIcon = "AppIcon"
    case launchScreen = "launch-screen"
    
    // Onboarding
    case onboarding1 = "OnboardFirst"
    case onboarding2 = "OnboardSecond"
    case onboarding3 = "onboarding-3"
    
    // Placeholders
    case recipePlaceholder = "recipe-placeholder"
    case avatarPlaceholder = "avatar-placeholder"
    case chefPlaceholder = "chef-placeholder"
    
    // Empty States
    case emptyRecipes = "empty-recipes"
    case emptyFavorites = "empty-favorites"
    case emptySearch = "empty-search"
    case errorState = "error-state"
    
    // Backgrounds
    case welcomeBackground = "welcome-background"
    case profileBackground = "profile-background"
    
    // Recipe Categories
    case categoryBreakfast = "category-breakfast"
    case categoryLunch = "category-lunch"
    case categoryDinner = "category-dinner"
    case categoryDessert = "category-dessert"
    case categoryVegetarian = "category-vegetarian"
    case categoryVegan = "category-vegan"
    
    // Social & UI
    case googleIcon = "google-icon"
    case facebookIcon = "facebook-icon"
    case appleIcon = "apple-icon"
    
    // Flags for localization
    case flagUS = "flag-us"
    case flagSpain = "flag-spain"
    case flagFrance = "flag-france"
    case flagItaly = "flag-italy"
    
    // Auth
    case facebook
    case google
    case eye
    
    // Header
    case back = "back"
    
    var image: Image {
        Image(self.rawValue)
    }
    
    var uiImage: UIImage? {
        UIImage(named: self.rawValue)
    }
}

// MARK: - Image Extension for Easy Access
extension Image {
    init(appImage: AppImage) {
        self.init(appImage.rawValue)
    }
}

// Usage:
// Image(appImage: .appLogo)
// AppImage.recipePlaceholder.image
