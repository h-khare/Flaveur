//
//  Endpoint.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

// MARK: - Endpoint Contract
public protocol Endpoint {
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String] { get }
    var queryItems: [String: String]? { get }
    var body: Encodable? { get }
    var timeout: TimeInterval { get }
    var decoder: JSONDecoder { get }
}

// Default safety fallback extensions for our protocol
public extension Endpoint {
    var timeout: TimeInterval { 30.0 }
    var decoder: JSONDecoder { JSONDecoder() }
    var queryItems: [String: String]? { nil }
    var body: Encodable? { nil }
    var headers: [String: String] { [:] }
}
