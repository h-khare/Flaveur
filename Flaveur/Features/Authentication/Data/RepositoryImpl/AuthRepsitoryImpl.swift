//
//  AuthRepsitoryImpl.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

class AuthRepsitoryImpl: AuthRepository{
    
    //MARK: - Properties
    private let authService: AuthService
    
    //MARK: - Initilization
    init(authService: AuthService) {
        self.authService = authService
    }
    
    //MARK: - Functions
    
    func login(credentials: LoginEntityPayload) async throws -> UserDTO {
        return try await authService.loginUser(payload: credentials)
    }
    
    func registerUser(credentials: SignupEntityPayload) async throws -> UserDTO {
        return try await authService.registerUser(payload: credentials)
    }
}
