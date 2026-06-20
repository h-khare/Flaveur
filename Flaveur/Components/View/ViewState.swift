//
//  ViewState.swift
//  Flaveur
//
//  Created by Harsh Khare on 20/06/26.
//

import Foundation

/// Defines the global states any screen in the app can face.
enum ViewState<T>: Equatable where T: Equatable {
    case idle
    case loading
    case success(T)
    case error(String)
}
