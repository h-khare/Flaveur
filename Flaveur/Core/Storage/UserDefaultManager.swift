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
    
    /// Tracks whether the user has login or not.
    ///
    /// Changes to this property automatically serialize directy to disk and emit updates
    /// to observing SwiftUI views.
    @Storage(key: .isLogin, defaultValue: false)
    public var isLogin: Bool
    
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
    
    /// Generic function to fetch and decode a stored value that might be missing, returning an optional.
    ///
    /// Use this method when a fallback default value does not make semantic sense (e.g., retrieving an optional active session user profile).
    ///
    /// - Parameter key: The type-safe `StorageKeys` enum case used to locate the value.
    /// - Returns: The expected deserialized object of type `T`, or `nil` if no data is found or decoding fails.
    public func fetchOptional<T: Decodable>(forKey key: StorageKeys) -> T? {
        guard let data = storage.data(forKey: key.rawValue) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    /// Removes the stored value associated with the specified type-safe key from persistence.
    ///
    /// Use this method to clear data dynamically (e.g., erasing a cached user profile during logout).
    /// If the key does not exist on disk, this operation performs no action safely.
    ///
    /// - Parameter key: The type-safe `StorageKeys` enum case to be removed from storage.
    public func remove(forKey key: StorageKeys) {
        storage.removeObject(forKey: key.rawValue)
    }
}
