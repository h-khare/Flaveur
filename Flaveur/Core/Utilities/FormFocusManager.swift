//
//  FormFocusManager.swift
//  Flaveur
//
//  Created by mac on 31/05/26.
//

import SwiftUI

class FormFocusManager<ID: Hashable & CaseIterable & Equatable>: ObservableObject {
    /// Tracks which field currently holds keyboard focus
    @Published var activeField: ID?
    
    /// Tracks whether a non-keyboard field sheet (like a DatePicker) should be visible
    @Published var showSheetField: Bool = false
    
    /// Auto-calculates the layout order and moves focus forward dynamically
    func advanceFocus(from currentField: ID, sheetFieldIdentity: ID? = nil) {
        let allFields = Array(ID.allCases)
        guard let currentIndex = allFields.firstIndex(of: currentField) else { return }
        
        let nextIndex = currentIndex + 1
        
        // If we are at the end of the form, dismiss the keyboard safely
        if nextIndex >= allFields.count {
            activeField = nil
            return
        }
        
        let nextField = allFields[nextIndex]
        
        // If the next field is identified as a sheet field (like Date Picker)
        if let sheetId = sheetFieldIdentity, nextField == sheetId {
            activeField = nil // Clear input focus so keyboard animates down
            
            // Allow keyboard window to clear frame layout constraints before popping sheet modal
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.showSheetField = true
            }
        } else {
            // Standard field interaction, simply advance target index focus pointer
            activeField = nextField
        }
    }
    
    /// Auto-calculates the layout order and moves focus backward dynamically
    func reverseFocus(from currentField: ID, sheetFieldIdentity: ID? = nil) {
        let allFields = Array(ID.allCases)
        guard let currentIndex = allFields.firstIndex(of: currentField), currentIndex > 0 else { return }
        
        let previousField = allFields[currentIndex - 1]
        
        // If stepping backward lands on the sheet field, drop over it into the text block before it
        if let sheetId = sheetFieldIdentity, previousField == sheetId {
            let skipIndex = currentIndex - 2
            if skipIndex >= 0 {
                activeField = allFields[skipIndex]
            } else {
                activeField = nil
            }
        } else {
            activeField = previousField
        }
    }
}
