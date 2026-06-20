//
//  CountryEntity.swift
//  Flaveur
//
//  Created by mac on 12/04/26.
//

import Foundation

struct CountryEntity: Codable{
    var countries: [Country]
}

struct Country: Codable{
    var name: String
    var flag: String
    var code: String
    var dialCode: String
    
    enum CodingKeys: String, CodingKey {
        case name, flag, code
        case dialCode = "dial_code"
    }
}
