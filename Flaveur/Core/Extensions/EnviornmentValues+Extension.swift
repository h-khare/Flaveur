//
//  EnviornmentValues+Extension.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

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
