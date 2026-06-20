//
//  ValidationRule.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import Foundation

/// Defines a distinct validation rule contract for input strings.

// MARK: - Core Rule Signature
public protocol ValidationRule: Sendable {
    func check(_ value: String) -> String?
}

// MARK: - Rule Collection
public struct RequiredRule: ValidationRule {
    public init() {}
    public func check(_ value: String) -> String? {
        value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "This field is required" : nil
    }
}

public struct EmailValidationRule: ValidationRule {
    public init() {}
    public func check(_ value: String) -> String? {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: value) ? nil : "Please enter a valid email"
    }
}

public struct MinLengthRule: ValidationRule {
    private let min: Int
    public init(_ min: Int) { self.min = min }
    public func check(_ value: String) -> String? {
        value.count < min ? "Minimum \(min) characters required" : nil
    }
}

public struct MaxLengthRule: ValidationRule {
    private let max: Int
    public init(_ max: Int) { self.max = max }
    public func check(_ value: String) -> String? {
        value.count > max ? "Maximum \(max) characters allowed" : nil
    }
}

public struct PasswordCriteriaRule: ValidationRule {
    public init() {}
    public func check(_ value: String) -> String? {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: value) ? nil : "Password must contain 8+ chars, uppercase, lowercase, number, and symbol."
    }
}

// MARK: - Streamlined Engine
public struct FieldValidator {
    let rules: [ValidationRule]
    public init(rules: [ValidationRule]) { self.rules = rules }
    
    public func validate(_ input: String) -> String? {
        for rule in rules {
            if let error = rule.check(input) { return error }
        }
        return nil
    }
}
