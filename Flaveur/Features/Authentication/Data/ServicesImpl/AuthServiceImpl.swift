//
//  AuthServiceImpl.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation


final class AuthServiceImpl: AuthService{
    
    //MARK: - Properties
    private let networkManager: NetworkService
    
    //MARK: - Initializer
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    //MARK: - Functions
    func loginUser(payload: LoginEntityPayload) async throws -> UserDTO {
        return try await networkManager.request(
            endpoint: RecipeEndpoint.login( credentials: payload),
            responseModel: UserDTO.self)
    }
    
    func registerUser(payload: SignupEntityPayload) async throws -> UserDTO {
        return try await networkManager.request(
            endpoint: RecipeEndpoint.register(payload: payload),
            responseModel: UserDTO.self)
    }
}
