//
//  CuisinesPreferenceView.swift
//  Flaveur
//
//  Created by mac on 06/04/26.
//

import SwiftUI

//MARK: - CuisinesPreferenceView
struct CuisinesPreferenceView: View {
    
    //MARK: - Properties
    @EnvironmentObject var appCoordinator: AppCoordinatorPresentor
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

//MARK: - Extension CuisinesPreferenceView
extension CuisinesPreferenceView{
    
    /// Content View
    @ViewBuilder
    private func contentView() -> some View {
        VStack(spacing: 20){
            heading()
            mainContent()
        }
        .padding(.horizontal, 36)
    }
    
    /// Main Content
    ///
    private func mainContent() -> some View {
        GeometryReader { geo in
            
            let spacing: CGFloat = 10
            let totalSpacing = spacing * 2 // 3 items → 2 gaps
            
            let itemWidth = (geo.size.width - totalSpacing) / 3
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.fixed(itemWidth)), count: 3),
                    spacing: spacing
                ) {
                    ForEach($presentor.cuisinesPreference, id: \.id) { level in
                        levelRow(level, size: itemWidth)
                    }
                }
            }
        }
    }
    
    /// Grid Column to display each row 3
    private func levelRow(
        _ level: Binding<CuisinesPreferenceModel>,
        size: CGFloat
    ) -> some View {
        _ = presentor.selectedLevelId == level.wrappedValue.id
        return VStack(spacing: 8) {
            
            Image(appImage: .onboarding1)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipped()
                .cornerRadius(12)
            
            AppText(
                level.wrappedValue.name,
                style: .labelMedium,
                color: theme.currentTheme.colors.textHeading
            )
        }
        .matchedGeometryEffect(id: level.wrappedValue.id, in: animation)
    }
    
    private func heading() -> some View{
        VStack(spacing: 20){
            AppText("Select your cuisines preferences", style:.recipeTitle, color: theme.currentTheme.colors.textHeading)
                .frame(maxWidth: .infinity, alignment: .leading)
            AppText("Please select your cuisines preferences for a better recommendations or you can skip it.", style:.labelRegular, color: theme.currentTheme.colors.textHeading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct CuisinesPreferenceView_PreviewProvider: PreviewProvider{
    @StateObject static private var themeManager = ThemeManager.create()
    @StateObject static var onBoardCoordinator: OnboardCoordinatorPresentor = OnboardCoordinatorPresentor(onboardDIContainer: OnboardDIContainer())
    
    static var previews: some View{
        CuisinesPreferenceView(presentor: PreferencePresentor())
            .environmentObject(themeManager)
            .environmentObject(onBoardCoordinator)
    }
}
