//
//  CookingLevelView.swift
//  Flaveur
//
//  Created by mac on 05/04/26.
//

import SwiftUI


//MARK: - CookingLevelView
struct CookingLevelView: View {
    
    //MARK: - Properties
    @EnvironmentObject var theme: ThemeManager
    @StateObject var presentor: PreferencePresentor
    @Namespace private var animation
    
    //MARK: - Body
    var body: some View {
        ///Main Content
        ///
        contentView()
    }
}

//MARK: - Extension Onboarding
extension CookingLevelView{
    
    /// Content View
    @ViewBuilder
    private func contentView() -> some View {
        VStack(spacing: 20){
            heading()
            mainContent()
        }
        .padding(.horizontal, 36)
    }
    
    private func mainContent() -> some View{
        ScrollView(showsIndicators: false){
            LazyVStack{
                ForEach($presentor.cookingLevels, id: \.id){ level in
                    levelRow(level)
                }
            }
        }
    }
    
    private func levelRow(_ level: Binding<CookingLevelModel>) -> some View{
        let isSelected = presentor.selectedLevelId == level.wrappedValue.id
        return VStack(spacing: 8){
            AppText(level.wrappedValue.name, style:.titleSmall, color: theme.currentTheme.colors.textHeading)
                .frame(maxWidth: .infinity, alignment: .leading)
            AppText(level.wrappedValue.description, style:.labelRegular, color: theme.currentTheme.colors.textHeading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }.padding(.vertical, 12)
            .padding(.horizontal, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        isSelected
                        ? theme.currentTheme.colors.primary
                        : theme.currentTheme.colors.primaryLight,
                        lineWidth: isSelected ? 2 : 1
                    )
            )
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation{
                    presentor.selectedLevelId = level.wrappedValue.id
                }
            }.matchedGeometryEffect(id: level.wrappedValue.id, in: animation)
    }
    
    private func heading() -> some View{
        VStack(spacing: 20){
            AppText("¿What is your cooking level?", style:.recipeTitle, color: theme.currentTheme.colors.textHeading)
                .frame(maxWidth: .infinity, alignment: .leading)
            AppText("Please select you cooking level for a better recommendations.", style:.labelRegular, color: theme.currentTheme.colors.textHeading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}

struct CookingLevelView_PreviewProvider: PreviewProvider{
    @StateObject static private var themeManager = ThemeManager.create()
    @StateObject static var onBoardCoordinator: OnboardCoordinatorPresentor = OnboardCoordinatorPresentor(onboardDIContainer: OnboardDIContainer())
    
    static var previews: some View{
        CookingLevelView(presentor: PreferencePresentor())
            .environmentObject(themeManager)
            .environmentObject(onBoardCoordinator)
    }
}
