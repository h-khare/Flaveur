//
//  FontDebug.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

#if DEBUG
struct FontDebugView: View {
    var body: some View {
        List {
            Section("Available Font Families") {
                ForEach(UIFont.familyNames.sorted(), id: \.self) { family in
                    VStack(alignment: .leading) {
                        Text(family)
                            .font(.headline)
                        
                        ForEach(UIFont.fontNames(forFamilyName: family).sorted(), id: \.self) { fontName in
                            Text(fontName)
                                .font(.custom(fontName, size: 14))
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
}

// Preview helper to check all text styles
struct TypographyPreview: View {
    @Environment(\.theme) private var theme
    
    let styles: [(AppTextStyle, String)] = [
        (.displayLarge, "Display Large"),
        (.displayMedium, "Display Medium"),
        (.displaySmall, "Display Small"),
        (.headlineLarge, "Headline Large"),
        (.headlineMedium, "Headline Medium"),
        (.headlineSmall, "Headline Small"),
        (.titleLarge, "Title Large"),
        (.titleMedium, "Title Medium"),
        (.titleSmall, "Title Small"),
        (.bodyLarge, "Body Large"),
        (.bodyMedium, "Body Medium"),
        (.bodySmall, "Body Small"),
        (.labelLarge, "Label Large"),
        (.labelMedium, "Label Medium"),
        (.labelSmall, "Label Small"),
        (.recipeTitle, "Recipe Title"),
        (.recipeDescription, "Recipe Description"),
        (.ingredientName, "Ingredient Name"),
        (.instructionStep, "Instruction Step"),
        (.chefName, "Chef Name"),
        (.cookingTime, "Cooking Time"),
//        (.quote, "Quote Text"),
//        (.price, "Price Text"),
//        (.badge, "Badge Text")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(styles, id: \.0) { style, name in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(name)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        AppText("The quick brown fox jumps over the lazy dog",
                               style: style)
                    }
                    .padding()
                    .background(theme.colors.surface)
                    .cornerRadius(8)
                }
            }
            .padding()
        }
        .background(theme.colors.background)
    }
}
#endif
