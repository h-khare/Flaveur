//
//  AppCoordinatorView.swift
//  Flaveur
//
//  Created by mac on 04/04/26.
//
import SwiftUI

// MARK: - AppCoordinatorView
struct AppCoordinatorView: View {
    
    // MARK: - Properties
    @EnvironmentObject private var container: DIContainer
    @EnvironmentObject var appCoordinator: AppCoordinatorPresentor
    
    // MARK: - Body
    var body: some View {
        // Using a ZStack instead of a Group stabilizes view layer rendering tracking during layout transitions
        ZStack {
            switch appCoordinator.appFlow {
            case .SPLASH:
                Text("Splash View")
                    .transition(.opacity) // Fade out splash smoothly
                
            case .ON_BOARDING:
                OnboardCoordinatorView()
                    .environmentObject(container.onboardCoordinator)
                    // Combine a slide-in transition from the edge with a clean fade effect
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                
            case .AUTH:
                AuthCoordinatorView()
                    .environmentObject(container.authDIContainer)
                    .environmentObject(container.authDIContainer.makeAuthCoordinatorPresentor)
                    // Cross-fade opacity mixed with a subtle scale-up bump animation
                    .transition(.opacity.combined(with: .scale(scale: 0.95, anchor: .center)))
                
            case .MAIN:
                Text("Main Dashboard View")
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .environmentObject(appCoordinator)
    }
}
