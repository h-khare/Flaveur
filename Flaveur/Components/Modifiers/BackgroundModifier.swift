//
//  BackgroundModifier.swift
//  Flaveur
//
//  Created by mac on 11/04/26.
//

import SwiftUI

struct BackgroundModifier: ViewModifier {
    @Environment(\.theme) var theme

    func body(content: Content) -> some View {
        ZStack {
            // Your Background Layer
            theme.colors.background
                .ignoresSafeArea()
            
            // Your Content Layer
            content
                // 1. Force the content view to fill the screen so it can be cleared
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                // 2. Remove the default system background from Lists/Forms
                .scrollContentBackground(.hidden)
                // 3. Ensure the underlying hosting view is clear
                .background(Color.clear)
        }
    }
}
