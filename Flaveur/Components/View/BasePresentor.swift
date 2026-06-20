//
//  BasePresentor.swift
//  Flaveur
//
//  Created by Harsh Khare on 20/06/26.
//

import SwiftUI

class BasePresentor<DataType: Equatable>: ObservableObject {
    /// The single source of truth for the screen's life cycle state
    @Published var state: ViewState<DataType> = .idle
    
    /// Global computed properties so your views don't have to parse the enum manually
    var isLoading: Bool {
        if case .loading = state { return true }
        return false
    }
    
    var errorMessage: String? {
        if case .error(let message) = state { return message }
        return nil
    }
}

/// A structural placeholder type representing an API operation that completes successfully without returning data.
struct EmptyResponse: Equatable {}
