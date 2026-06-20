//
//  AuthCoordinatorPresentor.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import SwiftUI

// MARK: AuthRoutes
enum AuthRoutes: String, CaseIterable, Hashable{
    case login
    case register
}

final class AuthCoordinatorPresentor: ObservableObject{
    
    // MARK: - Properties
    
    /// Reference to the container instance.
    /// Retain cycles are broken by making this reference clear without duplicate memory constraints.
    let authDIContainer: AuthDIContainer
    
    /// Centralized navigation state driver bound natively to a SwiftUI NavigationStack.
    @Published var routes = NavigationPath()
    
    // MARK: - Initilizater
    init(authDIContainer: AuthDIContainer){
        self.authDIContainer = authDIContainer
    }
    
    /// Appends a target destination route onto the active navigation view hierarchy stack.
    public func push(_ route: AuthRoutes) {
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
    public func build(_ route: AuthRoutes) -> some View {
        switch route {
        case .login:
            LoginView(presentor: self.authDIContainer.makeLoginPresentor)
            
        case .register:
            // Fixed typo bug: Target your intended second view component here cleanly
            SignUpView(presentor: self.authDIContainer.makeSignUpPresentor)
        }
    }
}
