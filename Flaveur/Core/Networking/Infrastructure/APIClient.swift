//
//  APIClient.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

// MARK: - API Client Interface
public protocol APIClient: Sendable {
    func execute(_ request: URLRequest) async throws -> (Data, URLResponse)
}
