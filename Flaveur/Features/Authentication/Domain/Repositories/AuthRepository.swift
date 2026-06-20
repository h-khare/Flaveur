//
//  AuthRepository.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

protocol AuthRepository{
    func login(credentials: LoginEntityPayload) async throws -> UserDTO
    func registerUser(credentials: SignupEntityPayload) async throws -> UserDTO
}
