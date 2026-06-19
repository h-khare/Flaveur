//
//  AuthenticationInterceptor.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

public final class AuthenticationInterceptor: RequestInterceptor {
    
    public init() {}
    
    public func intercept(_ request: URLRequest) async throws -> URLRequest {
        var modifiedRequest = request
        // Pretend we fetch this securely from Keychain or User Defaults
        let secureToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
        
        modifiedRequest.setValue("Bearer \(secureToken)", forHTTPHeaderField: "Authorization")
        return modifiedRequest
    }
}
