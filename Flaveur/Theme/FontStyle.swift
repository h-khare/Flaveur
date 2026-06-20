//
//  FontStyle.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI
// MARK: - Font Style
struct FontStyle {
    let family: FontFamily
    let weight: FontWeight
    let size: CGFloat
    let lineSpacing: CGFloat
    let letterSpacing: CGFloat
    
    init(family: FontFamily,
         weight: FontWeight,
         size: CGFloat,
         lineSpacing: CGFloat = 0,
         letterSpacing: CGFloat = 0) {
        self.family = family
        self.weight = weight
        self.size = size
        self.lineSpacing = lineSpacing
        self.letterSpacing = letterSpacing
    }
    
    var font: Font {
        FontManager.font(family: family, weight: weight, size: size)
    }
    
    var uiFont: UIFont {
        FontManager.uiFont(family: family, weight: weight, size: size)
    }
    
    // Dynamic Type Support
    func scaledFont(textStyle: UIFont.TextStyle = .body) -> Font {
        let metrics = UIFontMetrics(forTextStyle: textStyle)
        let scaledSize = metrics.scaledValue(for: size)
        return FontManager.font(family: family, weight: weight, size: scaledSize)
    }
}
