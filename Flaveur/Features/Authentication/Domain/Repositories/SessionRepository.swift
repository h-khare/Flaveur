//
//  SessionRepository.swift
//  Flaveur
//
//  Created by Harsh Khare on 20/06/26.
//
import Foundation

/// Defines the abstraction contract for persisting and retrieving user authentication session state.
protocol SessionRepository {
    /// Persists the authenticated user entity and marks the session active.
    func saveUserSession(_ user: User) async throws
    
    /// Retrieves the currently cached user session data model, if it exists.
    func fetchUserSession() async -> User?
    
    /// Clears all session credentials, logs the user out locally, and flags status preferences.
    func clearSession() async
}
