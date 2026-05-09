//
//  AppColorScheme.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

// MARK: - App Color Scheme Enum (Renamed to avoid conflict with SwiftUI.ColorScheme)
enum AppColorScheme: Int, CaseIterable {
    case system = 0
    case light = 1
    case dark = 2
    
    var displayName: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        case .system: return "System"
        }
    }
    
    var iconName: String {
        switch self {
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        case .system: return "gearshape.fill"
        }
    }
    
    // Convert to SwiftUI ColorScheme
    var toSwiftUIColorScheme: SwiftUI.ColorScheme? {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .system: return nil
        }
    }
    
    // Convert from SwiftUI ColorScheme
    static func from(_ scheme: SwiftUI.ColorScheme?) -> AppColorScheme {
        guard let scheme = scheme else { return .system }
        return scheme == .dark ? .dark : .light
    }
}
