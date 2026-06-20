//
//  FlaveurApp.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI
@main
struct FlaveurApp: App {
    
    //MARK: - Properties
    @StateObject private var themeManager = ThemeManager.create()
    @StateObject private var container = DIContainer()
    
    // Computed Properties
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
    
    //MARK: - Body
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView()
                .environmentObject(themeManager)
                .environmentObject(container)
                .environmentObject(container.appCoordinator)
                .environment(\.themeManager, themeManager)
                .environment(\.theme, themeManager.currentTheme)
                .preferredColorScheme(colorScheme)
        }
    }
}

//MARK: - AppPreview
struct FlaveurApp_PreviewProvider: PreviewProvider{
    
    //MARK: - Properties
    @StateObject static private var themeManager = ThemeManager.create()
    @StateObject static private var container = DIContainer()
    // Computed Properties
    static private var colorScheme: SwiftUI.ColorScheme? {
        switch themeManager.appColorScheme {
        case .system:
            return .light
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    //MARK: - Body
    static var previews: some View{
        AppCoordinatorView()
            .environmentObject(themeManager)
            .environmentObject(container)
            .environmentObject(container.appCoordinator)
            .environment(\.themeManager, themeManager)
            .environment(\.theme, themeManager.currentTheme)
            .preferredColorScheme(colorScheme)
    }
    
}
