//
//  URLSessionAPIClient.swift
//  Flaveur
//
//  Created by Harsh Khare on 24/05/26.
//

import Foundation

/// A concrete implementation of `APIClient` that executes requests over-the-air using standard `URLSession`.
public final class URLSessionAPIClient: APIClient {
    
    private let session: URLSession
    
    /// Initializes the client with a custom or shared `URLSession` instance.
    /// - Parameter session: The session to drive network data tasks (defaults to `.shared`).
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Coordinates raw execution metrics against standard data pipelines.
    public func execute(_ request: URLRequest) async throws -> (Data, URLResponse) {
        return try await session.data(for: request)
    }
}
