//
//  AuthService.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation


public protocol AuthService{
    func loginUser(payload: LoginEntityPayload) async throws -> UserDTO
    func registerUser(payload: SignupEntityPayload) async throws -> UserDTO
}
