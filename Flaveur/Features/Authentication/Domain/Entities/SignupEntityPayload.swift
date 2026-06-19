//
//  SignupEntity.swift
//  Flaveur
//
//  Created by mac on 31/05/26.
//

import Foundation

struct SignupEntityPayload: Encodable{
    
    let name: String
    let email: String
    let phone: String
    let countryCode: String
    let password: String
    
    enum CodingKeys: String, CodingKey{
        case name, email, phone, countryCode, password
    }
}
