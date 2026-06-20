//
//  OnBoardingThirdView.swift
//  Flaveur
//
//  Created by mac on 05/04/26.
//

import SwiftUI

struct OnBoardingThirdView: View {
    
    //MARK: - Properties
    @EnvironmentObject var onboardCoordinator: OnboardCoordinatorPresentor
    @EnvironmentObject var themeManager: ThemeManager
    let images = [1,2,3,4,5,6]
    
    //MARK: - Body
    var body: some View {
        /// App main Content
        content()
    }
}

//MARK: - Extension OnBoardingThirdView
extension OnBoardingThirdView{
    
    /// UI Content
    ///
    func content() -> some View{
        VStack(alignment: .leading,spacing:20){
            header()
            mainCards()
            footer()
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    /// Onboarding Header
    ///
    private func header() -> some View{
        Button{
            onboardCoordinator.pop()
        } label:{
            Image(appImage: .back)
        }.padding(.horizontal,20)
            .padding(.top, 10)
    }
    
    /// Main Images Cards
    ///
    private func mainCards() -> some View {
        GeometryReader { geo in
            
            let spacing: CGFloat = 27
            let totalSpacing = spacing * 2
            
            let availableHeight = max(geo.size.height, 1)
            let itemHeight = max((availableHeight - totalSpacing) / 3, 0)
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: 2),
                spacing: spacing
            ) {
                ForEach(0..<6) { _ in
                    Image(appImage: .onboarding1)
                        .resizable()
                        .scaledToFill()
                        .frame(height: itemHeight)
                        .clipped()
                        .cornerRadius(12)
                }
            }
        }
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 36)
    }
    
    /// Footer With Buttons
    ///
    private func footer() -> some View{
        VStack(spacing: 10){
            AppText("Welcome",style: .headlineSmall, color: themeManager.currentTheme.colors.textHeading,alignment: .center)
            AppText("Find the best recipes that the world can provide you also with every step that you can learn to increase your cooking skills.", style: .labelRegular,alignment: .center)
                .padding(.bottom, 14)
            button("I'm New"){
                onboardCoordinator.push(.preference)
            }
            button("I've Been Here"){
                
            }
        }
        .padding(.horizontal, 36)
        .padding(.bottom, 35)
    }
    
    
    /// Common Button Component
    ///
    private func button(_ text: String, callback: @escaping () -> Void) -> some View{
        Button{
            callback()
        } label: {
            AppText(text, style: .recipeTitle, color: themeManager.currentTheme.colors.vegan)
                .padding(.vertical,12)
                .padding(.horizontal, 57)
                .background(.primaryLight)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
    }
}

struct OnBoardingThirdView_PreviewProvider: PreviewProvider{
    
    @StateObject static var themeManager = ThemeManager.create()
    
    static var previews: some View{
        OnBoardingThirdView()
            .environmentObject(themeManager)
        
    }
}


