//
//  AppTextField.swift
//  Flaveur
//

import SwiftUI

struct AppTextField<ID: Hashable>: View {
    // MARK: - Reactive Field Properties
    @Binding var text: String
    let name: String
    let placeholder: String
    let type: AppFieldType
    var errorMessage: String?
    var countryCode: Binding<String>? = nil
    
    // MARK: - Decoupled Focus Routing System (Now Completely Optional)
    let fieldIdentity: ID?
    var focusState: FocusState<ID?>.Binding?
    
    // MARK: - Optional Overlays & Callbacks
    var isSheetPresented: Binding<Bool>?
    var onNext: (() -> Void)?
    var onPrevious: (() -> Void)?
    var isLastField: Bool
    
    // MARK: - Local Structural States
    @State private var isHide: Bool = true
    @State private var showCountryPicker = false
    @State private var selectedCountry: Country?
    @State private var showDatePicker = false
    @State private var internalDate = Date()
    @StateObject private var countryService = CountryService()
    
    // MARK: - Layout Environment Hooks
    @Environment(\.theme) var theme
    
    // MARK: - Flexible Initializer
    init(
        text: Binding<String>,
        name: String,
        placeholder: String,
        type: AppFieldType,
        errorMessage: String? = nil,
        countryCode: Binding<String>? = nil,
        fieldIdentity: ID? = nil,
        focusState: FocusState<ID?>.Binding? = nil,
        isSheetPresented: Binding<Bool>? = nil,
        onNext: (() -> Void)? = nil,
        onPrevious: (() -> Void)? = nil,
        isLastField: Bool = false
    ) {
        self._text = text
        self.name = name
        self.placeholder = placeholder
        self.type = type
        self.errorMessage = errorMessage
        self.countryCode = countryCode
        self.fieldIdentity = fieldIdentity
        self.focusState = focusState
        self.isSheetPresented = isSheetPresented
        self.onNext = onNext
        self.onPrevious = onPrevious
        self.isLastField = isLastField
    }
    
    // MARK: - Computed States
    private var isCurrentlyFocused: Bool {
        guard let focusState = focusState, let fieldIdentity = fieldIdentity else { return false }
        return focusState.wrappedValue == fieldIdentity
    }
    
    private var isDisplayingError: Bool {
        errorMessage != nil && !text.isEmpty
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            AppText(name, style: .titleSmall, color: theme.colors.textHeading)
            
            HStack(spacing: 8) {
                fieldLayer
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(theme.colors.primaryLight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(borderColor, lineWidth: 1)
                    )
            )
            .sheet(isPresented: $showCountryPicker) {
                CountryPickerView(service: countryService) { country in
                    self.selectedCountry = country
                    if let countryCodeBinding = self.countryCode {
                        countryCodeBinding.wrappedValue = country.dialCode
                    }
                }
            }
            .sheet(isPresented: isSheetPresented ?? $showDatePicker) {
                NavigationStack {
                    VStack {
                        DatePicker(
                            "",
                            selection: $internalDate,
                            in: ...Date(),
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .padding()
                        Spacer()
                    }
                    .navigationTitle(name)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                text = dateFormatter.string(from: internalDate)
                                if let externalBinding = isSheetPresented {
                                    externalBinding.wrappedValue = false
                                } else {
                                    showDatePicker = false
                                }
                                onNext?()
                            }
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                if let externalBinding = isSheetPresented {
                                    externalBinding.wrappedValue = false
                                } else {
                                    showDatePicker = false
                                }
                            }
                        }
                    }
                }
                .presentationDetents([.medium])
            }
            
            errorLabel
        }
        .animation(.easeIn(duration: 0.15), value: isCurrentlyFocused)
        .animation(.easeIn(duration: 0.15), value: isDisplayingError)
        // Toolbar only renders if focus state was actually supplied
        .toolbar {
            if isCurrentlyFocused {
                ToolbarItemGroup(placement: .keyboard) {
                    HStack {
                        Button(action: { onPrevious?() }) {
                            Image(systemName: "chevron.up")
                        }
                        .disabled(onPrevious == nil)
                        
                        Button(action: { onNext?() }) {
                            Image(systemName: "chevron.down")
                        }
                        .disabled(onNext == nil || isLastField)
                        
                        Spacer()
                        
                        Button(isLastField ? "Done" : "Next") {
                            if isLastField {
                                focusState?.wrappedValue = nil
                            } else {
                                onNext?()
                            }
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(theme.colors.primary)
                    }
                }
            }
        }
    }
}

// MARK: - Convenience Initialization for Non-Focused Standalone Fields
extension AppTextField where ID == String {
    /// Creates a lightweight standalone text field that doesn't participate in complex focus chains.
    init(
        text: Binding<String>,
        name: String,
        placeholder: String,
        type: AppFieldType,
        errorMessage: String? = nil
    ) {
        self.init(
            text: text,
            name: name,
            placeholder: placeholder,
            type: type,
            errorMessage: errorMessage,
            fieldIdentity: nil,
            focusState: nil
        )
    }
}

// MARK: - Subviews Layout Extension
private extension AppTextField {
    var borderColor: Color {
        if isDisplayingError { return .red }
        return isCurrentlyFocused ? theme.colors.primary : Color.gray.opacity(0.2)
    }
    
    @ViewBuilder
    var fieldLayer: some View {
        if type == .phone {
            countrySelector
            verticalDivider
        }
        
        ZStack(alignment: .leading) {
            if text.isEmpty {
                AppText(placeholder, style: .titleHeading, color: theme.colors.textSecondary)
                    .allowsHitTesting(false)
            }
            
            if type == .date {
                Button {
                    focusState?.wrappedValue = nil
                    if let existingDate = dateFormatter.date(from: text) {
                        internalDate = existingDate
                    }
                    if let externalBinding = isSheetPresented {
                        externalBinding.wrappedValue = true
                    } else {
                        showDatePicker = true
                    }
                } label: {
                    inputGroup
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            } else {
                inputGroup
            }
        }
        
        if !text.isEmpty && !type.isSecure && type != .date {
            Button { text = "" } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(theme.colors.textSecondary)
            }
        }
    }
    
    var countrySelector: some View {
        Button { showCountryPicker = true } label: {
            HStack(spacing: 4) {
                Text(selectedCountry?.flag ?? "🇮🇳")
                Text(selectedCountry?.dialCode ?? "+91")
                    .font(FontStyle(family: .poppins, weight: .medium, size: 14).font)
                Image(systemName: "chevron.down")
                    .font(.system(size: 8, weight: .bold))
            }
        }
        .foregroundStyle(theme.colors.textPrimary)
    }
    
    var verticalDivider: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: 1, height: 20)
    }
    
    @ViewBuilder
    var inputGroup: some View {
        // Safe binding unwrapping helper context
        let boundFocus = focusState ?? FocusState<ID?>().projectedValue
        
        switch type {
        case .password:
            HStack {
                if isHide {
                    SecureField("", text: $text)
                        .focused(boundFocus, equals: fieldIdentity)
                        .applyFieldAttributes(type)
                } else {
                    TextField("", text: $text)
                        .focused(boundFocus, equals: fieldIdentity)
                        .applyFieldAttributes(type)
                }
                
                Button { withAnimation(.spring(response: 0.2)) { isHide.toggle() } } label: {
                    Image(appImage: isHide ? .eye : .eye)
                }
            }
            .font(FontStyle(family: .poppins, weight: .medium, size: 14).font)
            .foregroundStyle(theme.colors.textPrimary)
            .tint(theme.colors.accent)
            
        case .date:
            TextField("", text: $text)
                .disabled(true)
                .allowsHitTesting(false)
                .applyFieldAttributes(type)
                .font(FontStyle(family: .poppins, weight: .medium, size: 14).font)
                .foregroundStyle(theme.colors.textPrimary)
                .tint(theme.colors.accent)
            
        default:
            TextField("", text: $text)
                .focused(boundFocus, equals: fieldIdentity)
                .submitLabel(isLastField ? .done : .next)
                .onSubmit { onNext?() }
                .applyFieldAttributes(type)
                .font(FontStyle(family: .poppins, weight: .medium, size: 14).font)
                .foregroundStyle(theme.colors.textPrimary)
                .tint(theme.colors.accent)
        }
    }
    
    var errorLabel: some View {
        Group {
            if isDisplayingError, let error = errorMessage {
                AppText(error, style: .chefName, color: .red)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                    .padding(.horizontal, 4)
            }
        }
    }
}
