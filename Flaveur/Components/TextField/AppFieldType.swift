//
//  AppFieldType.swift
//  Flaveur
//
//  Created by mac on 11/04/26.
//

import SwiftUI

//MARK: - AppFieldType
enum AppFieldType{
    
    //MARK: - Cases
    case text
    case email
    case password
    case phone
    case number
    case date
    
    //MARK: - Properties
    var keyboardType: UIKeyboardType{
        switch self{
        case .text:
            return .default
        case .email:
            return .emailAddress
        case .password:
            return .default
        case .phone:
            return .numberPad
        case .number:
            return .decimalPad
        case .date:
            return .default
        }
    }
    
    var isSecure: Bool{
        return self == .password
    }
    
    var autoCapitalization: TextInputAutocapitalization{
        switch self{
        case .text: return .sentences
        default: return .never
        }
    }
}
