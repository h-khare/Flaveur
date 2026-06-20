//
//  AppButton.swift
//  Flaveur
//

import SwiftUI

/// A design-system-compliant action button that handles normal operations,
/// asynchronous API loading cycles natively, visual validation states, and haptic feedback.
struct AppButton: View {
    
    // MARK: - Layout Environment Hooks
    @Environment(\.theme) var theme
    
    // MARK: - Reactive Controls
    /// Determines if the button is active or visually/functionally disabled.
    let isValid: Bool
    
    /// Controls the internal loading wheel visibility. Pass a binding to monitor API lifecycles automatically.
    @Binding var isLoading: Bool
    
    // MARK: - Properties
    var title: String
    var style: AppTextStyle = .recipeTitle
    
    /// The execution payload block. Supports async operations natively.
    var action: () -> Void
    
    // MARK: - Main Initializer
    init(
        title: String,
        isValid: Bool = true,
        isLoading: Binding<Bool> = .constant(false),
        style: AppTextStyle = .recipeTitle,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isValid = isValid
        self._isLoading = isLoading
        self.style = style
        self.action = action
    }
    
    // MARK: - Body View Layout
    var body: some View {
        Button(action: handleTapAction) {
            HStack(spacing: 8) {
                if isLoading {
                    // Modern inline micro-progress indicator
                    ProgressView()
                        .tint(theme.colors.vegan)
                        .controlSize(.small)
                        .transition(.scale.combined(with: .opacity))
                } else {
                    AppText(title, style: style, color: currentTextColor)
                        .transition(.push(from: .bottom))
                }
            }
            .frame(height: 48) // Explicit height boundary to ensure structural consistency during state changes
            .frame(maxWidth: .infinity) // Stretches naturally or adapts smoothly inside parent frame clipping layouts
            .padding(.horizontal, 24)
            .background(currentBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(currentBorderColor, lineWidth: 1)
            )
        }
        // Prevents multi-tap spamming during active API round-trips or when validation checks fail
        .disabled(!isValid || isLoading)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isLoading)
        .animation(.easeIn(duration: 0.2), value: isValid)
    }
}

// MARK: - Internal Helper Substructures
private extension AppButton {
    
    /// Safely processes the execution block while cleanly decoupling interactivity constraints.
    func handleTapAction() {
        // Trigger a subtle haptic feedback tap for modern tactile feel
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        action()
    }
    
    // MARK: - Dynamic Themes Styling Evaluators
    
    var currentTextColor: Color {
        guard isValid else { return theme.colors.textSecondary }
        return theme.colors.vegan
    }
    
    var currentBackgroundColor: Color {
        guard isValid else { return Color.gray.opacity(0.1) }
        return theme.colors.primaryLight // Replaced hardcoded literal reference safely
    }
    
    var currentBorderColor: Color {
        guard isValid else { return Color.gray.opacity(0.2) }
        return Color.clear
    }
}
