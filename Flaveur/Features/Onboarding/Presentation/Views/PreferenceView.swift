//
//  PreferenceView.swift
//  Flaveur
//
//  Created by mac on 05/04/26.
//

import SwiftUI

//MARK: - OnboardingFirst
struct PreferenceView: View {
    
    //MARK: - Properties
    @EnvironmentObject var theme: ThemeManager
    @EnvironmentObject private var appCoordinator: AppCoordinatorPresentor
    @EnvironmentObject var onboardCoordinator: OnboardCoordinatorPresentor
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
extension PreferenceView{
    
    /// Content View
    @ViewBuilder
    private func contentView() -> some View {
        // We use a ZStack or apply ignoresSafeArea to the main VStack
        // to ensure the images behind the text reach the top/bottom.
        VStack(alignment: .center, spacing: 0) {
            header()
            preferenceSteps()
            mainContent()
            footer()
        }
    }
    
    private func mainContent() -> some View {
        TabView(selection: $presentor.preferenceStep) {
            
            CookingLevelView(presentor: presentor)
                .tag(PreferenceSteps.cookingLevel)
            
            CuisinesPreferenceView(presentor: presentor)
                .tag(PreferenceSteps.preferences)
            
            AllergicView(presentor: presentor)
                .tag(PreferenceSteps.allergic)
        }
        .tabViewStyle(.page(indexDisplayMode: .never)) // hide dots if you want
        .animation(.easeInOut, value: presentor.preferenceStep)
    }
    
    private func preferenceSteps() -> some View{
        HStack(spacing:0){
            ForEach(PreferenceSteps.allCases, id: \.rawValue) { step in
                RoundedRectangle(cornerRadius: 12)
                    .fill(presentor.preferenceStep == step ? Color.primaryDark : .clear)
                    .frame(width: 65, height: 12)
                    .matchedGeometryEffect(id: step, in: animation)
            }
        }.background(theme.currentTheme.colors.seprator)
            .cornerRadius(12, corners: .allCorners)
            .padding(.top, 5)
            .padding(.bottom, 42)
    }
    
    /// Onboarding Header
    /// Onboarding Header
    ///
    private func header() -> some View{
        HStack{
            Button{
                withAnimation {
                    switch presentor.preferenceStep {
                    case .cookingLevel:
                        onboardCoordinator.pop()
                    case .preferences:
                        presentor.preferenceStep = .cookingLevel
                    case .allergic:
                        presentor.preferenceStep = .preferences
                    }
                }
            } label:{
                Image(appImage: .back)
            }.padding(.horizontal,20)
                .padding(.top, 10)
            Spacer()
        }
    }
    
    /// Footer
    ///
    private func footer() -> some View{
        HStack{
            if presentor.preferenceStep == .preferences{
                button("Skip", color: theme.currentTheme.colors.primary, background: theme.currentTheme.colors.primaryLight) {
                    
                }
            }
            
            button("Continue", color: theme.currentTheme.colors.background, background: theme.currentTheme.colors.primary) {
                withAnimation {
                    switch presentor.preferenceStep {
                    case .cookingLevel:
                        presentor.preferenceStep = .preferences
                    case .preferences:
                        presentor.preferenceStep = .allergic
                    case .allergic:
                        UserDefaultManager.shared.isOnboard = true
                        appCoordinator.updateFlow(to: .AUTH)
                    }
                }
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 36)
    }
    
    /// Common Button Component
    ///
    private func button(_ text: String, color: Color, background: Color, callback: @escaping () -> Void) -> some View{
        Button{
            callback()
        } label: {
            AppText(text, style: .recipeTitle, color: color)
                .padding(.vertical,11)
                .frame(maxWidth: 200)
                .background(background)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
    }
}

struct PreferenceView_PreviewProvider: PreviewProvider{
    @StateObject static private var themeManager = ThemeManager.create()
    @StateObject static var onBoardCoordinator: OnboardCoordinatorPresentor = OnboardCoordinatorPresentor(onboardDIContainer: OnboardDIContainer())
    
    static var previews: some View{
        PreferenceView(presentor: PreferencePresentor())
            .environmentObject(themeManager)
            .environmentObject(onBoardCoordinator)
    }
}
