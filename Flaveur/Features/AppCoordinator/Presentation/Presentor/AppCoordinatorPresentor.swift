//
//  AuthCoordinatorVM.swift
//  Flaveur
//
//  Created by mac on 04/04/26.
//

import SwiftUI

//MARK: - AppFlow
enum AppFlow: String, CaseIterable{
    case SPLASH = "Splash"
    case ON_BOARDING = "On Boarding"
    case AUTH = "Auth"
    case MAIN = "Main"
}

//MARK: - AppCoordinatorPresentor
final class AppCoordinatorPresentor:  ObservableObject{
    
    //MARK: - Properties
    @Published var appFlow: AppFlow = .ON_BOARDING
    
    // MARK: - Initializer
    init(){
        checkOnboarding()
    }
    
    /// Updates the global application destination state safely.
    @MainActor
    public func updateFlow(to newState: AppFlow) {
        withAnimation(.easeInOut(duration: 0.4)) {
            self.appFlow = newState
        }
    }
    
    /// Checking Onboarding
    ///
    func checkOnboarding(){
        if UserDefaultManager.shared.isOnboard{
            Task{
                await updateFlow(to: .AUTH)
            }
        }
    }
}
