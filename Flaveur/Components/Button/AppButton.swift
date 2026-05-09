//
//  ButtonView.swift
//  Flaveur
//
//  Created by mac on 05/04/26.
//

import SwiftUI

struct AppButton: View {
    
    //MARK: - Properties
    @Environment(\.theme) var theme
    var title: String
    var style: AppTextStyle = .recipeTitle
    var callback:(() -> Void)
    
    //MARK: - Body
    var body: some View {
        Button{
            callback()
        } label: {
            AppText(title, style: style, color: theme.colors.vegan)
                .padding(.vertical,12)
                .padding(.horizontal, 57)
                .background(.primaryLight)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
    }
}
