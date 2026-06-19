//
//  RecipeEndpoint.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

public enum RecipeEndpoint: Endpoint{
    
    //MARK: - AUTHENTICATION
    case login
    case register
    
    // MARK: - Properties
    public var path: String{
        switch self{
            
        case .login:
            return "/auth/login"
        case .register:
            return "/auth/register"
        }
    }
    
    public var method: HttpMethod{
        switch self{
            
        case .login, .register:
            return .POST
        }
    }
    
    // Inject URL Query parameters automatically if it's a list fetch
    public var queryItems: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}
