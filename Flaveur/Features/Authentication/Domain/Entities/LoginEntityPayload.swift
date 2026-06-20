//
//  LoginEntityPayload.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

public struct LoginEntityPayload: Encodable{
    
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey{
        case email
        case password
    }
}
