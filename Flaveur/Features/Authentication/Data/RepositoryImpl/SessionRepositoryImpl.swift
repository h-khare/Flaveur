//
//  SessionRepositoryImpl.swift
//  Flaveur
//
//  Created by Harsh Khare on 20/06/26.
//

import Foundation

/// A concrete implementation of `SessionRepository` handling persistence via an underlying local preferences wrapper.
final class SessionRepositoryImpl: SessionRepository {
    
    // MARK: - Dependencies
    private let defaults: UserDefaultManager
    
    // MARK: - Initializer
    /// Initializes the repository with a decoupled tracking manager reference.
    /// - Parameter defaults: The local storage utility framework. Defaults to the shared singleton instance.
    init() {
        self.defaults = UserDefaultManager.shared
    }
    
    // MARK: - Repository Protocol Methods
    
    /// Persists the User entity model and marks the session flag to true.
    func saveUserSession(_ user: User) async throws {
        // Enforce sequential thread execution steps using standard async boundaries safely
        defaults.isLogin = true
        defaults.save(user, forKey: .userData)
    }
    
    /// Fetches the authenticated user profile back from storage configurations cleanly.
    func fetchUserSession() async -> User? {
        // Assumes your UserDefaultManager has a generic read/fetch method matching the save capability
        return defaults.fetchOptional(forKey: .userData)
    }
    
    /// Erases local preferences variables completely to handle structural logout actions safely.
    func clearSession() async {
        defaults.isLogin = false
        defaults.remove(forKey: .userData)
    }
}
