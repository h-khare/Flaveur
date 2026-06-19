//
//  NetworkService.swift
//  Flaveur
//
//  Created by mac on 23/05/26.
//

import Foundation

// MARK: - Network Service Interface

/// A thread-safe contract that defines the execution behavior for a centralized application network service layer.
///
/// Any conforming type must support thread-safe execution (`Sendable`) and handle mapping abstract endpoint
/// definitions directly into strongly typed models through asynchronous operations.
public protocol NetworkService: Sendable {
    
    /// Requests a remote network resource and decodes the resulting payload into a generic data representation.
    ///
    /// - Parameters:
    ///   - endpoint: The configuration target outlining resource paths, method styles, parameter layouts, and mapping strategies.
    ///   - responseModel: The expected meta-type strategy (`T.Type`) to decode from the underlying response structure.
    /// - Returns: An instantiated representation matching the targeted `Decodable` model blueprint.
    /// - Throws: An error matching the `NetworkError` domain structure if serialization, transformation, transport, or validation steps fail.
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T
}
