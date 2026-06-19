//
//  NetworkError.swift
//  Flaveur
//
//  Created by mac on 23/05/26.
//

import Foundation


// MARK: - Network Error
public enum NetworkError: LocalizedError {
    
    case invalidURL
    case invalidResponse
    case noInternetConnection
    case decodingFailed
    case encodingFailed
    case unauthorized
    case serverError(statusCode: Int)
    case requestFailed(Error)
    case unknown
    
    public var errorDescription: String? {
        
        switch self {
            
        case .invalidURL:
            return "Invalid URL."
            
        case .invalidResponse:
            return "Invalid server response."
            
        case .noInternetConnection:
            return "No internet connection."
            
        case .decodingFailed:
            return "Failed to decode response."
            
        case .encodingFailed:
            return "Failed to encode request."
            
        case .unauthorized:
            return "Unauthorized access."
            
        case .serverError(let statusCode):
            return "Server error with status code: \(statusCode)"
            
        case .requestFailed(let error):
            return error.localizedDescription
            
        case .unknown:
            return "Unknown network error occurred."
        }
    }
}
