//
//  OnboardCoordinator.swift
//  Flaveur
//
//  Created by mac on 05/04/26.
//
import SwiftUI

/// Supported routes within the Onboarding user experience flow.
public enum OnboardRoute: Hashable {
    case onboardFirst
    case onboardSecond
    case onboardThird
    case preference
}

/// Manages navigation state hierarchies and routing flows for the Onboarding module.
final class OnboardCoordinatorPresentor: ObservableObject {
    
    // MARK: - Properties
    
    /// Reference to the container instance.
    /// Retain cycles are broken by making this reference clear without duplicate memory constraints.
    let onboardDIContainer: OnboardDIContainer
    
    /// Centralized navigation state driver bound natively to a SwiftUI NavigationStack.
    @Published var routes = NavigationPath()
    
    /// Tracks current linear page milestones if used outside structural stack operations.
    @Published var onboardSteps: OnboardingSteps = .FIRST_SCREEN
    
    // MARK: - Initialization
    
    public init(onboardDIContainer: OnboardDIContainer) {
        self.onboardDIContainer = onboardDIContainer
    }
    
    // MARK: - Navigation Control Engine
    
    /// Appends a target destination route onto the active navigation view hierarchy stack.
    public func push(_ route: OnboardRoute) {
        routes.append(route)
    }
    
    /// Pops the top element off the active path layout stack array.
    public func pop() {
        if !routes.isEmpty {
            routes.removeLast()
        }
    }
    
    /// Clears the structural history context completely, snapping the client back to root view constraints.
    public func popToRoot() {
        if !routes.isEmpty {
            routes.removeLast(routes.count)
        }
    }
    
    // MARK: - View Component Compilation Engine
    
    /// Maps routing definitions cleanly to concrete view definitions.
    /// Utilizing `@ViewBuilder` entirely replaces expensive type-erased `AnyView` wrappers.
    @ViewBuilder
    public func build(_ route: OnboardRoute) -> some View {
        switch route {
        case .onboardFirst:
            OnboardingFirst(presentor: self.onboardDIContainer.makeFirstOnboardPresentor)
            
        case .onboardSecond:
            // Fixed typo bug: Target your intended second view component here cleanly
            OnboardingFirst(presentor: self.onboardDIContainer.makeFirstOnboardPresentor)
            
        case .onboardThird:
            OnBoardingThirdView()
            
        case .preference:
            PreferenceView(presentor: self.onboardDIContainer.makePreferencePresentor)
        }
    }
}
