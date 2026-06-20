//
//  AuthUseCase.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

final class AuthUseCase{
    
    //MARK: - Properties
    private let authRepository: AuthRepository
    
    //MARK: - Initializer
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    /// Authenticate user using `email`and `password`.
    ///
    func login(credentials: LoginEntityPayload) async throws -> UserDTO{
        try await authRepository.login(credentials: credentials)
    }
    
    /// Authenticate user using `email`and `password`.
    ///
    func registerUser(credentials: SignupEntityPayload) async throws -> UserDTO{
        try await authRepository.registerUser(credentials: credentials)
    }
}
