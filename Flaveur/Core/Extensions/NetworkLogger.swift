//
//  NetworkLogger.swift
//  Flaveur
//
//  Created by Harsh Khare on 24/05/26.
//

import Foundation

/// A thread-safe, isolated structural logging engine tailored for network serialization tracking.
public final class NetworkLogger: Sendable {
    
    // MARK: - Singleton Instance
    public static let shared = NetworkLogger()
    
    private init() {}
    
    // MARK: - Public Request Logging Engine
    
    /// Compiles and prints clean cURL commands matching an outgoing URLRequest profile layout.
    public func log(request: URLRequest) {
        #if DEBUG
        guard let url = request.url else { return }
        var components = ["\n🔹 [NETWORK REQUEST] ---------------------------------------"]
        components.append("🌐 URL:     \(url.absoluteString)")
        components.append("🏷️ METHOD:  \(request.httpMethod ?? "GET")")
        
        // Format Headers
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            components.append("📋 HEADERS:")
            for (key, value) in headers {
                components.append("   ↳ \(key): \(value)")
            }
        }
        
        // Format JSON Body to string representation
        if let bodyData = request.httpBody {
            if let jsonString = String(data: bodyData, encoding: .utf8) {
                components.append("📦 BODY:\n\(jsonString)")
            }
        }
        
        // Generate terminal-executable cURL script
        components.append("💻 cURL COMMAND:")
        components.append(generateCurlCommand(for: request))
        components.append("-----------------------------------------------------------\n")
        
        print(components.joined(separator: "\n"))
        #endif
    }
    
    // MARK: - Public Response Logging Engine
    
    /// Inspects and prints incoming HTTP metadata alongside clean formatted JSON data maps.
    public func log(data: Data?, response: URLResponse?, error: Error? = nil) {
        #if DEBUG
        var components = ["\n🔸 [NETWORK RESPONSE] --------------------------------------"]
        
        if let httpResponse = response as? HTTPURLResponse {
            let statusIcon = (200...299).contains(httpResponse.statusCode) ? "✅" : "❌"
            components.append("\(statusIcon) STATUS CODE: \(httpResponse.statusCode)")
            components.append("🌐 URL:         \(httpResponse.url?.absoluteString ?? "Unknown URL")")
            
            if let headers = httpResponse.allHeaderFields as? [String: Any], !headers.isEmpty {
                components.append("📋 HEADERS:")
                for (key, value) in headers {
                    components.append("   ↳ \(key): \(value)")
                }
            }
        }
        
        if let error = error {
            components.append("💥 ERROR CRASH: \(error.localizedDescription)")
        }
        
        if let data = data, !data.isEmpty {
            components.append("📦 PAYLOAD RAW DATA:")
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let prettyString = String(data: prettyData, encoding: .utf8) {
                components.append(prettyString)
            } else if let rawString = String(data: data, encoding: .utf8) {
                components.append(rawString)
            }
        } else {
            components.append("📦 PAYLOAD: Empty Response Body.")
        }
        
        components.append("-----------------------------------------------------------\n")
        print(components.joined(separator: "\n"))
        #endif
    }
    
    // MARK: - Helper cURL Builder
    private func generateCurlCommand(for request: URLRequest) -> String {
        guard let url = request.url else { return "Unable to parse URL details." }
        var baseCommand = ["curl -i -X \(request.httpMethod ?? "GET") \"\(url.absoluteString)\""]
        
        if let headers = request.allHTTPHeaderFields {
            for (key, value) in headers {
                baseCommand.append("-H \"\(key): \(value)\"")
            }
        }
        
        if let bodyData = request.httpBody, let bodyString = String(data: bodyData, encoding: .utf8) {
            // Escape double quotes inside json string values
            let escapedBody = bodyString.replacingOccurrences(of: "\"", with: "\\\"")
            baseCommand.append("-d \"\(escapedBody)\"")
        }
        
        return baseCommand.joined(separator: " \\\n  ")
    }
}
