//
//  EnvironmentValues+Extension.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

// MARK: - Environment Keys
private struct ThemeManagerKey: EnvironmentKey {
    static let defaultValue: ThemeManager? = nil
}

private struct CurrentThemeKey: EnvironmentKey {
    static let defaultValue: AppTheme = LightTheme()
}

// MARK: - Environment Values Extension
extension EnvironmentValues {
    var themeManager: ThemeManager? {
        get { self[ThemeManagerKey.self] }
        set { self[ThemeManagerKey.self] = newValue }
    }
    
    var theme: AppTheme {
        get { self[CurrentThemeKey.self] }
        set { self[CurrentThemeKey.self] = newValue }
    }
}
