//
//  LoggingInterceptor.swift
//  Flaveur
//
//  Created by Harsh Khare on 24/05/26.
//

import Foundation

public final class LoggingInterceptor: RequestInterceptor, ResponseInterceptor {
    
    private let environment: AppEnvironment
    
    public init(environment: AppEnvironment) {
        self.environment = environment
    }
    
    // 1. Manage Pre-flight Request Lifecycle
    public func intercept(_ request: URLRequest) async throws -> URLRequest {
        if environment.shouldLogNetworkTraffic {
            NetworkLogger.shared.log(request: request)
        }
        return request
    }
    
    // 2. Manage Post-flight Response Lifecycle
    public func intercept(data: Data, response: URLResponse) async throws {
        if environment.shouldLogNetworkTraffic {
            NetworkLogger.shared.log(data: data, response: response)
        }
    }
}
