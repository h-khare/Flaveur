//
//  UserDefaultManager.swift
//  Flaveur
//
//  Created by mac on 31/05/26.
//

import Foundation

/// A thread-safe singleton manager responsible for handling application persistence via `UserDefaults`.
///
/// This manager bridges the gap between clean architecture layers and local storage by combining
/// a type-safe `@Storage` property wrapper for global app states and generic encoder/decoder functions
/// for dynamic or feature-specific data models.
public final class UserDefaultManager: ObservableObject {
    
    // MARK: - Properties
    
    /// The globally accessible shared instance of the `UserDefaultManager`.
    public static let shared = UserDefaultManager()
    
    /// The underlying reference to standard user defaults storage.
    private let storage: UserDefaults = .standard
    
    // MARK: - Initializer
    
    /// Private initializer to strictly enforce the singleton pattern and prevent duplicate instances.
    private init() {}
    
    // MARK: - All Stored Properties
    
    /// Tracks whether the user has completed the initial application onboarding flow.
    ///
    /// Changes to this property automatically serialize directly to disk and emit updates
    /// to observing SwiftUI views.
    @Storage(key: .isOnboard, defaultValue: false)
    public var isOnboard: Bool
    
    // MARK: - Methods
    
    /// Generic function to encode and persist any `Encodable` value into local storage.
    ///
    /// Use this method when you need to store custom structs, arrays, or data dynamically at runtime.
    ///
    /// - Parameters:
    ///   - value: The object conforming to `Encodable` that needs to be written to storage.
    ///   - key: The type-safe `StorageKeys` enum case representing the storage destination.
    public func save<T: Encodable>(_ value: T, forKey key: StorageKeys) {
        let data = try? JSONEncoder().encode(value)
        storage.set(data, forKey: key.rawValue)
    }
    
    /// Generic function to fetch and decode a stored value from the user default storage.
    ///
    /// This method includes a built-in safety net that returns a fallback value if no record
    /// exists or if decoding fails, eliminating the need to handle optional values in your business logic.
    ///
    /// - Parameters:
    ///   - key: The type-safe `StorageKeys` enum case used to locate the value.
    ///   - defaultValue: The fallback value returned if no data is found on disk or decoding fails.
    /// - Returns: The expected deserialized object of type `T`, or the provided `defaultValue`.
    public func fetch<T: Decodable>(forKey key: StorageKeys, defaultValue: T) -> T {
        guard let data = storage.data(forKey: key.rawValue) else { return defaultValue }
        let decodedValue = try? JSONDecoder().decode(T.self, from: data)
        return decodedValue ?? defaultValue
    }
}
