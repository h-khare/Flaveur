//
//  NetworkManager.swift
//  Flaveur
//
//  Created by mac on 16/05/26.
//

import Foundation

// MARK: - Network Manager Engine

/// A highly optimized engine managing interception sequences and response validation across structural endpoint paths.
///
/// This coordinator acts as an execution pipeline that coordinates a pluggable modular network architecture:
/// 1. Compiles request layouts via an isolated tracking dependency wrapper (`RequestBuilder`).
/// 2. Iteratively processes pre-flight request criteria sequences (e.g., Auth injection, telemetry stamping).
/// 3. Delegates raw over-the-air networking behaviors to an execution environment (`APIClient`).
/// 4. Iteratively checks post-flight server responses (e.g., central logging, state management triggers).
/// 5. Validates structural transport success states and maps payloads via custom endpoint decoders.
public final class NetworkManager: NetworkService {
    
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
    
    /// Initializes a network manager instance populated with configurable dependency blocks.
    ///
    /// - Parameters:
    ///   - requestBuilder: An instance of a dedicated request compilation model.
    ///   - apiClient: The underlying transport network engine (typically wrapping a `URLSession` channel).
    ///   - requestInterceptors: Pre-execution pipelines running prior to server interactions (defaults to an empty collection).
    ///   - responseInterceptors: Post-execution pipelines running after data has arrived (defaults to an empty collection).
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
    /// This operational pipeline flows through six distinct phases:
    /// 1. **Compilation**: Maps the endpoint layout data to an internal `URLRequest` structural target.
    /// 2. **Pre-flight Interception**: Mutates request properties matching external pipeline conditions.
    /// 3. **Transport**: Executes network transmission asynchronously through an isolated abstraction hook.
    /// 4. **Post-flight Interception**: Triggers tracking audits or status checks on received response fields.
    /// 5. **Validation**: Enforces strict conformance checks against unexpected or broken HTTP response ranges.
    /// 6. **Parsing**: Processes raw server arrays into concrete entity maps via specified localized object decoders.
    ///
    /// - Parameters:
    ///   - endpoint: An object implementing the structural layout maps of an individual endpoint resource.
    ///   - responseModel: The expected data target layout mapping signature.
    /// - Returns: A decoded model instance matching the specified blueprint layout parameters.
    /// - Throws: `NetworkError` variants including `.invalidResponse`, `.unauthorized`, `.serverError`, or `.decodingFailed`.
    public func request<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async throws -> T {
        
        // 1. Build Base Target Request Configuration
        var request = try requestBuilder.buildRequest(from: endpoint)
        
        // 2. Cascade Request Modification Interceptors sequentially
        for interceptor in requestInterceptors {
            request = try await interceptor.intercept(request)
        }
        
        // 3. Execute Over-The-Air Network Operation via Client Isolation Layer
        let (data, response) = try await apiClient.execute(request)
        
        // 4. Cascade Post-Execution Validation or Analytics Interceptors sequentially
        for interceptor in responseInterceptors {
            try await interceptor.intercept(data: data, response: response)
        }
        
        // 5. Explicitly Validate Protocol Properties and Error States
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
        
        // 6. Decode Content targeting Endpoint Customization Properties
        do {
            return try endpoint.decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
