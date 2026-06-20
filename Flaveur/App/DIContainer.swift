//
//  DIContainer.swift
//  Flaveur
//
//  Created by mac on 04/04/26.
//

import Foundation

//MARK: - DIContainer
final class DIContainer: ObservableObject{
    
    // MARK: - Properties
    let networkService: NetworkService
    
    // MARK: - Initializers
    /// Initializes the root application container by injecting assembled dependencies.
    ///
    /// By defaulting to `NetworkAssembly.assemble`, your production app works seamlessly out-of-the-box,
    /// but still allows you to pass in an alternate mock network engine during automated system tests.
    init(networkService: NetworkService = NetworkAssembly.assemble(environment: .production)) {
        self.networkService = networkService
    }
    
    //App Coordinator
    lazy var appCoordinator: AppCoordinatorPresentor = {
        AppCoordinatorPresentor()
    }()
    
    lazy var onboardDIContainer = OnboardDIContainer()
    
    lazy var onboardCoordinator = OnboardCoordinatorPresentor(
        onboardDIContainer: onboardDIContainer
    )
    
    // MARK: Auth DI Container
    lazy var authDIContainer:AuthDIContainer = {
        AuthDIContainer(networkService: networkService)
    }()
}
