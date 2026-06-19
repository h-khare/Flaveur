//
//  RequestBuilder.swift
//  Flaveur
//
//  Created by mac on 23/05/26.
//

import Foundation

/// An instance-driven builder responsible for serializing structural `Endpoint` models into concrete `URLRequest` configurations.
///
/// This class handles localized base URL resolution, handles structured percent-encoding for query items,
/// maps headers safely, and automates HTTP body JSON payload serialization. It conforms to `Sendable`
/// to guarantee complete thread safety across modern Swift concurrency models.
public final class RequestBuilder: Sendable {
    
    // MARK: - Properties
    
    /// The default base domain URL path string (e.g., `"https://api.flaveur.com"`).
    private let baseURL: String

    // MARK: - Initializer
    
    /// Creates a request builder configured against a fixed base root target domain.
    ///
    /// - Parameter baseURL: The primary base endpoint domain location against which all localized paths are resolved.
    public init(baseURL: String) {
        self.baseURL = baseURL
    }

    // MARK: - Public Build Engine
    
    /// Compiles an abstract `Endpoint` definition down into an execution-ready `URLRequest`.
    ///
    /// This engine sequences parameter layout steps across:
    /// 1. Appending the localized endpoint path to the structural base domain.
    /// 2. Parsing and mapping query dictionaries safely into formal `URLQueryItem` objects.
    /// 3. Initializing standard URL properties like caching configurations and customized timeout gates.
    /// 4. Serializing structural `Encodable` body parameters into JSON while handling matching `Content-Type` fallback markers.
    ///
    /// - Parameter endpoint: The domain-specific implementation containing configuration details for a network call.
    /// - Returns: A fully configured and pipeline-compatible `URLRequest` instance.
    /// - Throws: `NetworkError.invalidURL` if processing components fails validation, or `NetworkError.encodingFailed` if the body data format breaks structural serialization.
    public func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        
        // Resolve absolute location paths dynamically by concatenating base and sub-path layers
        let absoluteURLString = baseURL + endpoint.path
        guard var components = URLComponents(string: absoluteURLString) else {
            throw NetworkError.invalidURL
        }

        // Safely break down structural properties into formatted percent-encoded query pairs
        if let queryItems = endpoint.queryItems {
            components.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        // 3. Extract the compiled URL path from the modified component layout properties
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        // Instantiate core request parameters incorporating contextual timeout properties
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: endpoint.timeout)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers

        // Evaluate and process incoming generic body payloads safely
        if let bodyPayload = endpoint.body {
            // Apply application/json content-type fallback marker if not manually explicitly specified
            if request.value(forHTTPHeaderField: "Content-Type") == nil {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            // Attempt layout serialization of the generic target data format payload
            do {
                request.httpBody = try JSONEncoder().encode(bodyPayload)
            } catch {
                throw NetworkError.encodingFailed
            }
        }

        return request
    }
}
