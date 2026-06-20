//
//  AppEnvironment.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

/// Supported execution environments for the application ecosystem.
public enum AppEnvironment: String, CaseIterable, Sendable {
    case development = "Development"
    case staging = "Staging"
    case production = "Production"
    
    /// Resolves the absolute base domain configuration rule matching the environment target.
    public var baseURL: String {
        switch self {
        case .development:
            return "https://dev-api.flaveur.com"
        case .staging:
            return "https://staging-api.flaveur.com"
        case .production:
            return "https://flaveur.onrender.com/api/v1"
        }
    }
    
    /// Global default connection gate timeout limits tailored per environment context rules.
    public var defaultTimeout: TimeInterval {
        switch self {
        case .development, .staging:
            return 45.0 // Longer allowance for tracing slow debugger break-points
        case .production:
            return 30.0 // Tight validation constraints for optimal client throughput
        }
    }
    
    /// Appends standard logging strategies depending on environment context values.
    public var shouldLogNetworkTraffic: Bool {
        switch self {
        case .development, .staging: return true
        case .production: return false
        }
    }
}
