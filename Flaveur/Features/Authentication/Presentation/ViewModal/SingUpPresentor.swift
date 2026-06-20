//
//  SignUpPresenter.swift
//  Flaveur
//
//  Created by mac on 12/04/26.
//

import Foundation
import Combine

public enum SignUpField: Hashable, CaseIterable {
    case fullName, email, phone, dateOfBirth, password, confirmPassword
}

// MARK: - SignUpPresenter
class SignUpPresenter: BasePresenter {
    
    // MARK: - Properties
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var countryCode: String = ""
    @Published var dateOfBirth: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    /// Central single source of truth error tracking container map
    @Published var errors: [SignUpField: String] = [:]
    @Published var isFormValid = false
    
    private var cancellables = Set<AnyCancellable>()
    private var useCase: AuthUseCase
    
    private let validationRegistry: [SignUpField: FieldValidator] = [
        .fullName: FieldValidator(rules: [RequiredRule(), MinLengthRule(3), MaxLengthRule(50)]),
        .email:    FieldValidator(rules: [RequiredRule(), EmailValidationRule()]),
        .phone:    FieldValidator(rules: [RequiredRule(), MinLengthRule(5), MaxLengthRule(15)]),
        .password: FieldValidator(rules: [RequiredRule(), PasswordCriteriaRule()]),
        .confirmPassword: FieldValidator(rules: [RequiredRule()])
    ]
    
    // MARK: - Initializer
    // MARK: - Initializer
    public init(useCase: AuthUseCase) {
        self.useCase = useCase
        super.init()
        self.setupValidationPipeline()
    }
    
    // MARK: - Functions
    private func setupValidationPipeline() {
        // Combining 5 fields requires nesting or combining multiple publishers.
        // We can combine the first 4, then combine that result with the 5th field.
        let firstFour = Publishers.CombineLatest4($fullName, $email, $phone, $password)
        
        Publishers.CombineLatest(firstFour, $confirmPassword)
        // Debounce prevents rapid evaluation UI jitter while typing
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] (firstFourValues, currentConfirmPassword) in
                guard let self = self else { return }
                
                let (name, currentEmail, currentPhone, currentPassword) = firstFourValues
                var incomingErrors: [SignUpField: String] = [:]
                
                let inputMap: [SignUpField: String] = [
                    .fullName: name,
                    .email: currentEmail,
                    .phone: currentPhone,
                    .password: currentPassword,
                    .confirmPassword: currentConfirmPassword
                ]
                
                for (field, value) in inputMap {
                    if let error = self.validationRegistry[field]?.validate(value) {
                        incomingErrors[field] = error
                    }
                }
                
                if !currentConfirmPassword.isEmpty && currentPassword != currentConfirmPassword {
                    incomingErrors[.confirmPassword] = "Passwords do not match."
                }
                
                self.errors = incomingErrors
                
                // The form is valid only if all required fields have values and there are no errors
                let allFieldsFilled = !name.isEmpty && !currentEmail.isEmpty && !currentPhone.isEmpty && !currentPassword.isEmpty && !currentConfirmPassword.isEmpty
                self.isFormValid = incomingErrors.isEmpty && allFieldsFilled
            }
            .store(in: &cancellables)
    }
    
    ///
    ///
    @MainActor
    func registerUser() async {
        await executeTask({ [weak self] in
            try await self?.useCase.registerUser(credentials: SignupEntityPayload(
                name: self?.fullName ?? "",
                email: self?.email ?? "",
                phone: self?.phone ?? "",
                countryCode: self?.countryCode ?? "",
                password: self?.password ?? ""
            ))
        }, onSuccess: { authPayload in
            if let payload = authPayload {
                print(payload)
            }
        })
    }
}
