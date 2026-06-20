//
//  PrimaryButtonStyle.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

//// MARK: - Button Style
//struct PrimaryButtonStyle: ButtonStyle {
//    @Environment(\.theme) private var theme
//    @Environment(\.isEnabled) private var isEnabled
//    
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .textStyle(theme.typography.labelLarge, color: theme.colors.textOnPrimary)
//            .padding(.horizontal, theme.spacing.large)
//            .padding(.vertical, theme.spacing.medium)
//            .frame(maxWidth: .infinity)
//            .background(background(configuration: configuration))
//            .cornerRadius(theme.cornerRadius.button)
//            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
////            .animation(theme.buttonPress, value: configuration.isPressed)
//    }
//    
//    @ViewBuilder
//    private func background(configuration: Configuration) -> some View {
//        if isEnabled {
//            if configuration.isPressed {
//                theme.colors.primaryDark
//            } else {
//                theme.colors.primary
//            }
//        } else {
//            theme.colors.disabled
//        }
//    }
//}
