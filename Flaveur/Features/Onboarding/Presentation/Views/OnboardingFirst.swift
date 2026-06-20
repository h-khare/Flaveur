//
//  OnboardingFirst.swift
//  Flaveur
//
//  Created by mac on 09/03/26.
//

import SwiftUI

//MARK: - OnboardingFirst
struct OnboardingFirst: View {
    
    //MARK: - Properties
    @EnvironmentObject var theme: ThemeManager
    @EnvironmentObject var onboardCoordinator: OnboardCoordinatorPresentor
    @StateObject var presentor: OnBoardingPresentor
    
    //MARK: - Body
    var body: some View {
        ///Main Content
        ///
        contentView()
            .appBackground()
    }
}

//MARK: - Extension Onboarding
extension OnboardingFirst{
    
    /// Content View
    @ViewBuilder
    private func contentView() -> some View {
        // We use a ZStack or apply ignoresSafeArea to the main VStack
        // to ensure the images behind the text reach the top/bottom.
        VStack(alignment: .leading, spacing: 0) {
            header()
            heading()
            onBoardContent()
        }
        .ignoresSafeArea(.container, edges: .all)
    }
    
    private func heading() -> some View{
        VStack(alignment: .leading,spacing: 10){
            AppText("Get inspired", style: .recipeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            AppText("Get inspired with our daily recipe recommendations.", style: .labelRegular)
        }
        .padding(20)
    }
    
    /// Onboarding Header
    private func header() -> some View {
        Button {
            withAnimation {
                onboardCoordinator.onboardSteps = .FIRST_SCREEN
            }
        } label: {
            Image(appImage: .back)
        }
        .padding(.horizontal, 20)
        .padding(.top, 60)
        
    }
    
    /// Onboarding replacable component
    private func onBoardContent() -> some View {
        ZStack(alignment: .bottom) {
            
            // IMAGE
            Group {
                if onboardCoordinator.onboardSteps == .FIRST_SCREEN {
                    Image(appImage: .onboarding1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image(appImage: .onboarding2)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            
            // TOP GRADIENT
            VStack {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.white, .white.opacity(0)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: 300)
                Spacer()
            }
            
            footer()
        }
        .ignoresSafeArea()
    }
    
    /// Footer
    private func footer() -> some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [.white.opacity(0.0), .white],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 150)
            
            button("Continue") {
                withAnimation(.linear(duration: 0.3)) {
                    if onboardCoordinator.onboardSteps == .FIRST_SCREEN {
                        onboardCoordinator.onboardSteps = .SECOND_SCREEN
                    } else {
                        onboardCoordinator.push(.onboardThird)
                    }
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    /// Common Button Component
    ///
    private func button(_ text: String, callback: @escaping () -> Void) -> some View{
        Button{
            callback()
        } label: {
            AppText(text, style: .recipeTitle, color: theme.currentTheme.colors.vegan)
                .padding(.vertical,12)
                .padding(.horizontal, 57)
                .background(.primaryLight)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
    }
}

struct OnboardingFirst_PreviewProvider: PreviewProvider{
    @StateObject static private var themeManager = ThemeManager.create()
    @StateObject static var onBoardCoordinator: OnboardCoordinatorPresentor = OnboardCoordinatorPresentor(onboardDIContainer: OnboardDIContainer())
    
    static var previews: some View{
        OnboardingFirst(presentor: OnBoardingPresentor())
            .environmentObject(themeManager)
            .environmentObject(onBoardCoordinator)
    }
}
