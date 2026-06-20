//
//  CaseIterable+Extension.swift
//  Flaveur
//
//  Created by mac on 31/05/26.
//

import Foundation

extension CaseIterable where Self: Equatable {
    /// Safely finds the next sequential enum case in a sequence.
    func next() -> Self? {
        let all = Array(Self.allCases)
        guard let index = all.firstIndex(of: self), index + 1 < all.count else { return nil }
        return all[index + 1]
    }
    
    /// Safely finds the previous sequential enum case in a sequence.
    func previous() -> Self? {
        let all = Array(Self.allCases)
        guard let index = all.firstIndex(of: self), index - 1 >= 0 else { return nil }
        return all[index - 1]
    }
}
