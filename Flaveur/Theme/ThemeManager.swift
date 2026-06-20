//
//  ThemeManager.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI
import Combine


// MARK: - Theme Manager
@MainActor
final class ThemeManager: ObservableObject {
    @Published private(set) var currentTheme: AppTheme
    @Published private(set) var appColorScheme: AppColorScheme
    
    private let userDefaults: UserDefaults
    private let notificationCenter: NotificationCenter
    private var cancellables = Set<AnyCancellable>()
    
    // Private initializer - use create() factory method
    private init(userDefaults: UserDefaults,
                 notificationCenter: NotificationCenter,
                 appColorScheme: AppColorScheme,
                 currentTheme: AppTheme) {
        self.userDefaults = userDefaults
        self.notificationCenter = notificationCenter
        self.appColorScheme = appColorScheme
        self.currentTheme = currentTheme
        
        setupObservers()
    }
    
    // MARK: - Factory Method
    static func create(userDefaults: UserDefaults = .standard,
                       notificationCenter: NotificationCenter = .default) -> ThemeManager {
        // Compute values before initialization
        let savedSchemeRaw = userDefaults.integer(forKey: "appColorScheme")
        let appColorScheme = AppColorScheme(rawValue: savedSchemeRaw) ?? .system
        let currentTheme = Self.theme(for: appColorScheme)
        
        return ThemeManager(
            userDefaults: userDefaults,
            notificationCenter: notificationCenter,
            appColorScheme: appColorScheme,
            currentTheme: currentTheme
        )
    }
    
    // MARK: - Theme Selection
    func setColorScheme(_ scheme: AppColorScheme) {
        appColorScheme = scheme
        userDefaults.set(scheme.rawValue, forKey: "appColorScheme")
        
        withAnimation(.easeInOut(duration: 0.3)) {
            currentTheme = Self.theme(for: scheme)
        }
        
        notificationCenter.post(name: .themeDidChange, object: nil)
    }
    
    func toggleTheme() {
        let newScheme: AppColorScheme = appColorScheme == .dark ? .light : .dark
        setColorScheme(newScheme)
    }
    
    // MARK: - Private Methods
    private static func theme(for scheme: AppColorScheme) -> AppTheme {
        switch scheme {
        case .dark:
            return DarkTheme()
        case .light:
            return LightTheme()
        case .system:
            let isDark = UITraitCollection.current.userInterfaceStyle == .dark
            return isDark ? DarkTheme() : LightTheme()
        }
    }
    
    private func setupObservers() {
        // Observe system appearance changes
        NotificationCenter.default.publisher(for: NSNotification.Name(rawValue: "AppleInterfaceThemeChangedNotification"))
            .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.systemThemeChanged()
            }
            .store(in: &cancellables)
    }
    
    private func systemThemeChanged() {
        // Only auto-update if using system setting
        guard appColorScheme == .system else { return }
        
        Task { @MainActor in
            let isDark = UITraitCollection.current.userInterfaceStyle == .dark
            let newTheme: AppTheme = isDark ? DarkTheme() : LightTheme()
            
            withAnimation(.easeInOut(duration: 0.3)) {
                self.currentTheme = newTheme
            }
            
            notificationCenter.post(name: .themeDidChange, object: newTheme)
        }
    }
}
