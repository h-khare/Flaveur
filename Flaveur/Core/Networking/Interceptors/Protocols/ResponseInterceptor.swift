//
//  ResponseInterceptor.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

public protocol ResponseInterceptor: Sendable {
    /// Allows the interceptor to inspect metrics, parse errors, or trigger token refreshes.
    func intercept(data: Data, response: URLResponse) async throws
}
