//
//  NetworkAssembly.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

import Foundation

/// A dedicated assembly factory that encapsulates the construction logic for the application's network infrastructure.
public struct NetworkAssembly {
    
    /// Compiles and builds the production network engine pipeline configuration.
    /// - Parameter baseDomain: The base root target domain for all endpoints (e.g., "https://api.flaveur.com").
    /// - Returns: A configured, thread-safe `NetworkService` instance.
    public static func assemble(environment: AppEnvironment) -> NetworkService {
        // Instantiate the foundational data utilities
        let requestBuilder = RequestBuilder(baseURL: environment.baseURL)
        let apiClient = URLSessionAPIClient()
        let loggerInterceptor = LoggingInterceptor(environment: .development)
        
        // Setup your plug-and-play interceptor middlewares
        let authInterceptor = AuthenticationInterceptor()
        
        // Assemble and return the centralized pipeline engine manager
        return NetworkManager(
            requestBuilder: requestBuilder,
            apiClient: apiClient,
            requestInterceptors: [authInterceptor, loggerInterceptor],
            responseInterceptors: [loggerInterceptor]
        )
    }
}
