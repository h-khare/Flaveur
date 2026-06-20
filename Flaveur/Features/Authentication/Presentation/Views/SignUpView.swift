//
//  SignUpView.swift
//  Flaveur
//
//  Created by mac on 12/04/26.
//

import SwiftUI

struct SignUpView: View {
    
    // MARK: - Properties
    @ObservedObject var presentor: SignUpPresenter
    @EnvironmentObject var authCoordinator: AuthCoordinatorPresentor
    @StateObject private var focusManager = FormFocusManager<SignUpField>()
    @FocusState private var activeField: SignUpField?
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Invisible background touch receiver clears focus safely without intercepting child elements
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture { activeField = nil }
            
            content
        }
        .appBackground()
        .navigationBarBackButtonHidden(true)
        .synchronize($focusManager.activeField, with: $activeField)
    }
}

// MARK: - Subviews Layout Extension
private extension SignUpView {
    var content: some View {
        VStack(spacing: 0){
            AppText("Sign Up", style: .titleLarge)
                .padding(.vertical, 40)
            ScrollView(showsIndicators:false) {
                singupForm
                loginButtonSection
                socialContent
            }
        }
        .padding(.horizontal, 20)
    }
    
    var singupForm: some View {
        VStack(spacing: 8) {
            
            AppTextField(
                text: $presentor.fullName,
                name: "Full Name",
                placeholder: "Enter name here",
                type: .text,
                errorMessage: presentor.errors[.fullName],
                fieldIdentity: .fullName,
                focusState: $activeField,
                onNext: { focusManager.advanceFocus(from: .fullName, sheetFieldIdentity: .dateOfBirth) }
            )
            
            AppTextField(
                text: $presentor.email,
                name: "Email",
                placeholder: "Enter email here",
                type: .email,
                errorMessage: presentor.errors[.email],
                fieldIdentity: .email,
                focusState: $activeField,
                onNext: { focusManager.advanceFocus(from: .email, sheetFieldIdentity: .dateOfBirth) },
                onPrevious: { focusManager.reverseFocus(from: .email, sheetFieldIdentity: .dateOfBirth) }
            )
            
            AppTextField(
                text: $presentor.phone,
                name: "Phone Number",
                placeholder: "Enter number here",
                type: .phone,
                errorMessage: presentor.errors[.phone],
                countryCode: $presentor.countryCode,
                fieldIdentity: .phone,
                focusState: $activeField,
                onNext: { focusManager.advanceFocus(from: .phone, sheetFieldIdentity: .dateOfBirth) },
                onPrevious: { focusManager.reverseFocus(from: .phone, sheetFieldIdentity: .dateOfBirth) }
            )
            
            // Date Picker Sheet visibility is fully dynamic, derived from the focus manager shared state
            AppTextField(
                text: $presentor.dateOfBirth,
                name: "Date of Birth",
                placeholder: "Select Date of Birth",
                type: .date,
                errorMessage: presentor.errors[.dateOfBirth],
                fieldIdentity: .dateOfBirth,
                focusState: $activeField,
                isSheetPresented: $focusManager.showSheetField,
                onNext: { focusManager.advanceFocus(from: .dateOfBirth, sheetFieldIdentity: .dateOfBirth) }
            )
            
            AppTextField(
                text: $presentor.password,
                name: "Password",
                placeholder: "Enter password here",
                type: .password,
                errorMessage: presentor.errors[.password],
                fieldIdentity: .password,
                focusState: $activeField,
                onNext: { focusManager.advanceFocus(from: .password, sheetFieldIdentity: .dateOfBirth) },
                onPrevious: { focusManager.reverseFocus(from: .password, sheetFieldIdentity: .dateOfBirth) }
            )
            
            AppTextField(
                text: $presentor.confirmPassword,
                name: "Confirm Password",
                placeholder: "Confirm password here",
                type: .password,
                errorMessage: presentor.errors[.confirmPassword],
                fieldIdentity: .confirmPassword,
                focusState: $activeField,
                onPrevious: { focusManager.reverseFocus(from: .confirmPassword, sheetFieldIdentity: .dateOfBirth) },
                isLastField: true
            )
        }
    }
    
    var loginButtonSection: some View {
        VStack(spacing: 10){
            AppText("By continuing, you agree to \nTerms of Use and Privacy Policy.", style: .cookingTime, alignment: .center)
            AppButton(
                        title: "Sign Up",
                        isValid: presentor.isFormValid,
                        // Dynamic custom binding built on the fly from the global state enum!
                        isLoading: Binding(
                            get: { presentor.isLoading },
                            set: { _ in } // Read-only from the view side
                        ),
                        style: .recipeTitle
                    ) {
                        activeField = nil
                        Task{
                            await presentor.registerUser()
                        }
                    }
        }
    }
    
    var socialContent: some View {
        VStack(spacing: 16) {
            AppText("or Sign up with", style: .instructionStep)
            
            HStack(spacing: 24) {
                SocialIcon(image: .google) {  }
                SocialIcon(image: .facebook) {  }
            }
            
            Button(action: { authCoordinator.pop() }) {
                AppText("Already have an account? Login", style: .instructionStep)
            }
        }.padding(.vertical, 20)
    }
}

// MARK: - Reusable Components
private struct SocialIcon: View {
    let image: AppImage
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(appImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
        }
    }
}

// MARK: - Preview Generator
//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView(presentor: SignUpPresenter(useCase: AuthUseCase(authRepository: AuthRepsitoryImpl(authService: AuthRepsitoryImpl(authService: <#T##any AuthService#>)))))
//    }
//}
