//
//  NetworkManager.swift
//  Flaveur
//
//  Created by Harsh Khare on 16/05/26.
//

import Foundation

// MARK: - Network Manager Engine

/// A thread-safe actor engine managing interception sequences and response validation across structural endpoint paths.
///
/// This coordinator acts as an isolated execution pipeline that coordinates a pluggable modular network architecture.
/// Converted to an actor to prevent multithreaded data-race crashes (EXC_BREAKPOINT) during simultaneous calls.
public actor NetworkManager: NetworkService {
    
    // MARK: - Immutable Dependencies
    
    /// The local mapping driver responsible for building structured requests out of target endpoints.
    private let requestBuilder: RequestBuilder
    
    /// The execution layer client responsible for performing abstract HTTP data tasks.
    private let apiClient: APIClient
    
    /// An ordered collection of interception blocks evaluated sequentially prior to issuing over-the-air transfers.
    private let requestInterceptors: [RequestInterceptor]
    
    /// An ordered collection of inspection blocks evaluated sequentially after finishing data extraction steps.
    private let responseInterceptors: [ResponseInterceptor]
    
    // MARK: - Initialization
    
    public init(
        requestBuilder: RequestBuilder,
        apiClient: APIClient,
        requestInterceptors: [RequestInterceptor] = [],
        responseInterceptors: [ResponseInterceptor] = []
    ) {
        self.requestBuilder = requestBuilder
        self.apiClient = apiClient
        self.requestInterceptors = requestInterceptors
        self.responseInterceptors = responseInterceptors
    }
    
    // MARK: - Execution Pipeline
    
    /// Executes the underlying network orchestration sequence for a target endpoint layout.
    ///
    /// This operational pipeline flows through six distinct phases in an isolated actor context.
    /// - Parameters:
    ///   - endpoint: An object implementing the structural layout maps of an individual endpoint resource.
    ///   - responseModel: The expected data target layout mapping signature.
    /// - Returns: A decoded model instance matching the specified blueprint layout parameters.
    public func request<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async throws -> T {
        
        // Build Base Target Request Configuration Safely
        var request = try requestBuilder.buildRequest(from: endpoint)
        
        // Cascade Request Modification Interceptors sequentially
        for interceptor in requestInterceptors {
            request = try await interceptor.intercept(request)
        }
        
        // Execute Over-The-Air Network Operation via Client Isolation Layer
        // Wrapped safely inside the actor context to prevent thread pool corruption
        let (data, response) = try await apiClient.execute(request)
        
        // Cascade Post-Execution Validation or Analytics Interceptors sequentially
        for interceptor in responseInterceptors {
            try await interceptor.intercept(data: data, response: response)
        }
        
        // Explicitly Validate Protocol Properties and Error States
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            // Standard success path execution continuation
            break
        case 401:
            throw NetworkError.unauthorized
        default:
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        // Decode Content targeting Endpoint Customization Properties
        do {
            return try endpoint.decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
