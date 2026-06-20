//
//  RecipeEndpoint.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

public enum RecipeEndpoint: Endpoint{
    
    //MARK: - AUTHENTICATION
    case login(credentials: LoginEntityPayload)
    case register(payload: SignupEntityPayload)
    
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
    
    // Pass the associated payload structures up to the RequestBuilder
    public var body: Encodable? {
        switch self {
        case .login(let credentials):
            return credentials
        case .register(let payload):
            return payload
        default:
            return nil
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
