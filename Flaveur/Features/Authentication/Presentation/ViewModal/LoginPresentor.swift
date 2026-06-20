//
//  LoginPresentor.swift
//  Flaveur
//
//  Created by Harsh Khare on 11/04/26.
//

import Combine
import Foundation

enum LoginField {
    case email
    case password
}

// MARK: - LoginPresentor
class LoginPresentor: ObservableObject {
    
    // MARK: - Properties
    @Published var loginValidate: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    
    /// Central single source of truth error tracking container map
    @Published var errors: [LoginField: String] = [:]
    
    private var useCase: AuthUseCase
    private var cancellables = Set<AnyCancellable>()
    
    private let validationRegistry: [LoginField: FieldValidator] = [
        .email:    FieldValidator(rules: [RequiredRule(), EmailValidationRule()]),
        .password: FieldValidator(rules: [RequiredRule(), PasswordCriteriaRule()])
    ]
    
    init(useCase: AuthUseCase) {
        self.useCase = useCase
        setupValidationPipeline()
    }
    
    // MARK: - Functions
    
    private func setupValidationPipeline() {
        Publishers.CombineLatest($email, $password)
            .receive(on: RunLoop.main)
            .sink { [weak self] currentEmail, currentPassword in
                guard let self = self else { return }
                
                var incomingErrors: [LoginField: String] = [:]
                let inputMap: [LoginField: String] = [
                    .email: currentEmail, .password: currentPassword
                ]
                
                for (field, value) in inputMap {
                    if let error = self.validationRegistry[field]?.validate(value) {
                        incomingErrors[field] = error
                    }
                }
                
                self.errors = incomingErrors
                self.loginValidate = incomingErrors.isEmpty
            }
            .store(in: &cancellables)
    }
    
    func callLoginAPI() async{
        do{
            let result = try await useCase.login(credentials: LoginEntityPayload(email: email, password: password))
            debugPrint(result)
        }catch{
            
        }
    }
}
