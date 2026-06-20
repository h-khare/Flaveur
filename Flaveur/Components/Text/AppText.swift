//
//  AppText.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

struct AppText: View {
    // MARK: - Properties
    private let content: TextContent
    private let style: AppTextStyle
    private let color: Color?
    private let alignment: TextAlignment
    private let lineLimit: Int?
    private let minimumScaleFactor: CGFloat
    private let truncationMode: Text.TruncationMode
    private let isInteractive: Bool
    private let action: (() -> Void)?
    
    @Environment(\.theme) private var theme
    @State private var isPressed = false
    
    // MARK: - Content Type
    private enum TextContent {
        case localized(LocalizedStringKey)
        case plain(String)
        case verbatim(String)
        case formatted(String, [CVarArg])
        case plural(String, Int)
    }
    
    // MARK: - Initializers
    init(_ key: LocalizedStringKey,
         style: AppTextStyle = .bodyMedium,
         color: Color? = nil,
         alignment: TextAlignment = .leading,
         lineLimit: Int? = nil,
         minimumScaleFactor: CGFloat = 1.0,
         truncationMode: Text.TruncationMode = .tail,
         isInteractive: Bool = false,
         action: (() -> Void)? = nil) {
        self.content = .localized(key)
        self.style = style
        self.color = color
        self.alignment = alignment
        self.lineLimit = lineLimit
        self.minimumScaleFactor = minimumScaleFactor
        self.truncationMode = truncationMode
        self.isInteractive = isInteractive
        self.action = action
    }
    
    init(_ string: String,
         style: AppTextStyle = .bodyMedium,
         color: Color? = nil,
         alignment: TextAlignment = .leading,
         lineLimit: Int? = nil,
         minimumScaleFactor: CGFloat = 1.0,
         truncationMode: Text.TruncationMode = .tail,
         isInteractive: Bool = false,
         action: (() -> Void)? = nil) {
        self.content = .plain(string)
        self.style = style
        self.color = color
        self.alignment = alignment
        self.lineLimit = lineLimit
        self.minimumScaleFactor = minimumScaleFactor
        self.truncationMode = truncationMode
        self.isInteractive = isInteractive
        self.action = action
    }
    
    init(verbatim string: String,
         style: AppTextStyle = .bodyMedium,
         color: Color? = nil,
         alignment: TextAlignment = .leading,
         lineLimit: Int? = nil,
         minimumScaleFactor: CGFloat = 1.0,
         truncationMode: Text.TruncationMode = .tail,
         isInteractive: Bool = false,
         action: (() -> Void)? = nil) {
        self.content = .verbatim(string)
        self.style = style
        self.color = color
        self.alignment = alignment
        self.lineLimit = lineLimit
        self.minimumScaleFactor = minimumScaleFactor
        self.truncationMode = truncationMode
        self.isInteractive = isInteractive
        self.action = action
    }
    
    // MARK: - Body
    var body: some View {
        Group {
            switch content {
            case .localized(let key):
                Text(key)
            case .plain(let string):
                Text(string)
            case .verbatim(let string):
                Text(verbatim: string)
            case .formatted(let key, let args):
                Text(String(format: NSLocalizedString(key, comment: ""), arguments: args))
            case .plural(let key, let count):
                let formatKey = count == 1 ? "\(key).singular" : "\(key).plural"
                let format = NSLocalizedString(formatKey, comment: "")
                Text(String(format: format, count))
            }
        }
        .modifier(TextStyleModifier(
            style: style,
            color: color,
            alignment: alignment,
            lineLimit: lineLimit,
            minimumScaleFactor: minimumScaleFactor,
            truncationMode: truncationMode
        ))
        .scaleEffect(isInteractive && isPressed ? 0.98 : 1.0)
        .animation(isInteractive ? .easeInOut(duration: 0.1) : nil, value: isPressed)
        .if(isInteractive) { view in
            view.onTapGesture {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isPressed = false
                    action?()
                }
            }
        }
    }
}

// MARK: - Convenience Initializers
extension AppText {
    static func screenTitle(_ key: LocalizedStringKey) -> AppText {
        AppText(key, style: .headlineLarge, alignment: .leading)
    }
    
    static func sectionTitle(_ key: LocalizedStringKey) -> AppText {
        AppText(key, style: .titleLarge, alignment: .leading)
    }
    
    static func cardTitle(_ key: LocalizedStringKey) -> AppText {
        AppText(key, style: .recipeTitle, alignment: .leading)
    }
    
    static func ingredient(_ name: String) -> AppText {
        AppText(name, style: .ingredientName)
    }
    
    static func instruction(_ step: String) -> AppText {
        AppText(step, style: .instructionStep)
    }
    
    static func chef(_ name: String) -> AppText {
        AppText(name, style: .chefName)
    }
    
//    static func cookingTime(_ minutes: Int) -> AppText {
//        AppText(plural: "cooking_time", count: minutes, style: .cookingTime)
//    }
    
//    static func quote(_ text: String) -> AppText {
//        AppText(text, style: .quote)
//    }
//    
//    static func price(_ amount: Double, currency: String = "$") -> AppText {
//        AppText("\(currency)\(String(format: "%.2f", amount))", style: .price)
//    }
//    
//    static func badge(_ text: String) -> AppText {
//        AppText(text, style: .badge)
//    }
}

// MARK: - View Extension for Conditional Modifier
extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
