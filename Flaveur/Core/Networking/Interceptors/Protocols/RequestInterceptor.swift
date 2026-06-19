//
//  RequestInterceptor.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

// MARK: - Interceptor Infrastructure
public protocol RequestInterceptor: Sendable {
    func intercept(_ request: URLRequest) async throws -> URLRequest
}
