////
////  ValidationRule.swift
////  Flaveur
////
////  Created by mac on 11/04/26.
////
//
//import Foundation
//
//enum ValidationRule {
//    
//    case minLength(Int)
//    case maxLength(Int)
//    case email
//    case required
//    
//    // Password validation
//    case password
//    
//    // Confirm password validation
//    case confirmPassword(String)
//    
//    func check(_ value: String) -> String? {
//        
//        switch self {
//            
//        case .minLength(let min):
//            return value.count < min
//            ? "Minimum \(min) characters required"
//            : nil
//            
//        case .maxLength(let max):
//            return value.count > max
//            ? "Maximum \(max) characters allowed"
//            : nil
//            
//        case .email:
//            
//            let emailRegex =
//            "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//            
//            let predicate = NSPredicate(
//                format: "SELF MATCHES %@",
//                emailRegex
//            )
//            
//            return predicate.evaluate(with: value)
//            ? nil
//            : "Please enter a valid email"
//            
//        case .required:
//            
//            return value
//                .trimmingCharacters(in: .whitespaces)
//                .isEmpty
//            ? "This field is required"
//            : nil
//            
//        case .password:
//            
//            // Minimum:
//            // 8 characters
//            // 1 uppercase
//            // 1 lowercase
//            // 1 number
//            // 1 special character
//            
//            let passwordRegex =
//            "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
//            
//            let predicate = NSPredicate(
//                format: "SELF MATCHES %@",
//                passwordRegex
//            )
//            
//            return predicate.evaluate(with: value)
//            ? nil
//            : """
//            Password must contain:
//            • 8+ characters
//            • Uppercase letter
//            • Lowercase letter
//            • Number
//            • Special character
//            """
//            
//        case .confirmPassword(let password):
//            
//            return value == password
//            ? nil
//            : "Passwords do not match"
//        }
//    }
//}
