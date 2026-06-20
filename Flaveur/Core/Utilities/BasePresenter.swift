//
//  BasePresenter.swift
//  Flaveur
//
//  Created by mac on 31/05/26.
//

import Foundation
class BasePresenter: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showErrorAlert: Bool = false
    
    // A centralized, re-usable execution block
    @MainActor
    func executeTask<T>(_ task: @escaping () async throws -> T, onSuccess: @escaping (T) -> Void) async {
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            let result = try await task()
            onSuccess(result)
        } catch let error as NetworkError {
            self.handleNetworkError(error)
        } catch {
            self.errorMessage = "An unexpected error occurred."
            self.showErrorAlert = true
        }
        
        self.isLoading = false
    }
    
    private func handleNetworkError(_ error: NetworkError) {
        self.errorMessage = error.errorDescription
        self.showErrorAlert = true
    }
}
