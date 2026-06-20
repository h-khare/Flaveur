//
//  UserDTO.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

// MARK: - UserDTO
public struct UserDTO: Codable {
    let success: Bool?
    let message: String?
    let data: UserDTOData?
    let statusCode: Int?
    let timestamp: String?
}

// MARK: - DataClass
public struct UserDTOData: Codable {
    let user: User?
    let accessToken, refreshToken: String?
}

// MARK: - User
public struct User: Codable {
    let userID, name, email, bio: String?
    let phone, role, countryCode, profilePicture, cookingLevel: String?
    let preferences, allergies: [String]?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case name, email, role, bio, phone, countryCode, profilePicture, cookingLevel, preferences, allergies, createdAt
    }
}
