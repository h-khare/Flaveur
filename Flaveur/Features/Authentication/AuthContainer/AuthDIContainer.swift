//
//  AuthDIContainer.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

final class AuthDIContainer: ObservableObject{
    
    // MARK: - Properties
    private let networkService: NetworkService
    
    // MARK: - Initializer
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: Presentor
    lazy var makeLoginPresentor: LoginPresentor = {
       LoginPresentor(useCase: authUseCase)
    }()
    
    lazy var makeSignUpPresentor: SignUpPresenter = {
        SignUpPresenter(useCase: authUseCase)
    }()
    
    lazy var makeAuthCoordinatorPresentor: AuthCoordinatorPresentor = {
        AuthCoordinatorPresentor(authDIContainer: self)
    }()
    
    // MARK: Services
    lazy var authService: AuthService = {
        AuthServiceImpl(networkManager: networkService)
    }()
    
    // MARK: - Repositories
    lazy var authRepository: AuthRepository = {
        AuthRepsitoryImpl(authService: authService)
    }()
    
    // MARK: - Use Cases
    lazy var authUseCase: AuthUseCase = {
        AuthUseCase(authRepository: authRepository)
    }()
}
