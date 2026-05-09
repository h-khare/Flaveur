//
//  FlaveurApp.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI
@main
struct FlaveurApp: App {
    @StateObject private var themeManager = ThemeManager.create()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .environment(\.themeManager, themeManager)
                .environment(\.theme, themeManager.currentTheme)
                .preferredColorScheme(colorScheme)
        }
    }
    
    private var colorScheme: SwiftUI.ColorScheme? {
        switch themeManager.appColorScheme {
        case .system:
            return .light
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
