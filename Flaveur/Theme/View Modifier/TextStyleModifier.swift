//
//  TextStyleModifier.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

struct TextStyleModifier: ViewModifier {
    @Environment(\.theme) private var theme
    let style: AppTextStyle
    let color: Color?
    let alignment: TextAlignment
    let lineLimit: Int?
    let minimumScaleFactor: CGFloat
    let truncationMode: Text.TruncationMode
    
    init(style: AppTextStyle,
         color: Color? = nil,
         alignment: TextAlignment = .leading,
         lineLimit: Int? = nil,
         minimumScaleFactor: CGFloat = 1.0,
         truncationMode: Text.TruncationMode = .tail) {
        self.style = style
        self.color = color
        self.alignment = alignment
        self.lineLimit = lineLimit
        self.minimumScaleFactor = minimumScaleFactor
        self.truncationMode = truncationMode
    }
    
    func body(content: Content) -> some View {
        let fontStyle = theme.typography.style(for: style)
        
        content
            .font(fontStyle.font)
            .foregroundColor(color ?? theme.colors.textPrimary)
            .lineSpacing(fontStyle.lineSpacing)
            .tracking(fontStyle.letterSpacing)
            .multilineTextAlignment(alignment)
            .lineLimit(lineLimit)
            .minimumScaleFactor(minimumScaleFactor)
            .truncationMode(truncationMode)
    }
}

// MARK: - View Extension
extension View {
    func textStyle(
        _ style: AppTextStyle,
        color: Color? = nil,
        alignment: TextAlignment = .leading,
        lineLimit: Int? = nil,
        minimumScaleFactor: CGFloat = 1.0,
        truncationMode: Text.TruncationMode = .tail
    ) -> some View {
        modifier(TextStyleModifier(
            style: style,
            color: color,
            alignment: alignment,
            lineLimit: lineLimit,
            minimumScaleFactor: minimumScaleFactor,
            truncationMode: truncationMode
        ))
    }
    
    // Convenience methods
    func displayStyle(_ size: DisplaySize = .medium,
                     color: Color? = nil) -> some View {
        switch size {
        case .large:
            return textStyle(.displayLarge, color: color)
        case .medium:
            return textStyle(.displayMedium, color: color)
        case .small:
            return textStyle(.displaySmall, color: color)
        }
    }
    
    func headlineStyle(_ size: HeadlineSize = .medium,
                      color: Color? = nil) -> some View {
        switch size {
        case .large:
            return textStyle(.headlineLarge, color: color)
        case .medium:
            return textStyle(.headlineMedium, color: color)
        case .small:
            return textStyle(.headlineSmall, color: color)
        }
    }
    
    func titleStyle(_ size: TitleSize = .medium,
                   color: Color? = nil) -> some View {
        switch size {
        case .large:
            return textStyle(.titleLarge, color: color)
        case .medium:
            return textStyle(.titleMedium, color: color)
        case .small:
            return textStyle(.titleSmall, color: color)
        }
    }
    
    func bodyStyle(_ size: BodySize = .medium,
                  color: Color? = nil) -> some View {
        switch size {
        case .large:
            return textStyle(.bodyLarge, color: color)
        case .medium:
            return textStyle(.bodyMedium, color: color)
        case .small:
            return textStyle(.bodySmall, color: color)
        }
    }
    
    func labelStyle(_ size: LabelSize = .medium,
                   color: Color? = nil) -> some View {
        switch size {
        case .large:
            return textStyle(.labelLarge, color: color)
        case .medium:
            return textStyle(.labelMedium, color: color)
        case .small:
            return textStyle(.labelSmall, color: color)
        }
    }
}

// MARK: - Size Enums
enum DisplaySize {
    case large, medium, small
}

enum HeadlineSize {
    case large, medium, small
}

enum TitleSize {
    case large, medium, small
}

enum BodySize {
    case large, medium, small
}

enum LabelSize {
    case large, medium, small
}
