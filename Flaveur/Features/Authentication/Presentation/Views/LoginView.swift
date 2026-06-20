//
//  LoginView.swift
//  Flaveur
//
//  Created by mac on 11/04/26.
//
import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties
    @EnvironmentObject var appCoordinator: AppCoordinatorPresentor
    @EnvironmentObject var authCoordinator: AuthCoordinatorPresentor
    @FocusState private var activeField: LoginField?
    
    // Changed to ObservedObject assuming the Presenter is injected by a Coordinator/Router.
    // Use @StateObject only if LoginView is the absolute owner and creator of the Presenter.
    @ObservedObject var presentor: LoginPresentor
    
    // MARK: - Body
    var body: some View {
        ZStack {
            content
        }
        .appBackground()
        // Moves the focus off textfields when tapping outside
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

// MARK: - Subviews
private extension LoginView {
    
    // Computed property instead of a function for static layouts (slight performance gain)
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                AppText("Login", style: .titleLarge)
                    .padding(.top, 40)
                
                // Use predictable padding boxes instead of chaotic Spacers
                loginForm
                    .padding(.top, 60)
                
                loginButtonSection
                    .padding(.top, 40)
                
                socialContent
                    .padding(.top, 60)
                    .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
        }
        // Force inline display settings straight to the root of the stack container view
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
    }
    
    var loginForm: some View {
        VStack(spacing: 8) { // Increased spacing for better visual breathing room
            AppTextField(
                text: $presentor.email,
                name: "Email",
                placeholder: "Enter email here",
                type: .email,
                errorMessage: presentor.errors[.email],
                fieldIdentity: .email,
                focusState: $activeField,
                onNext: { activeField = .email },
                onPrevious: { activeField = .password }
            )
            
            AppTextField(
                text: $presentor.email,
                name: "Email",
                placeholder: "Enter email here",
                type: .email,
                errorMessage: presentor.errors[.email],
                fieldIdentity: .email,
                focusState: $activeField,
                onNext: { activeField = .email },
                onPrevious: { activeField = .password },
                isLastField: true
            )
        }
    }
    
    var loginButtonSection: some View {
        VStack(spacing: 12) {
            AppButton(isValidate: $presentor.loginValidate, title: "Log In") {
                Task{
                    await presentor.callLoginAPI()
                }
            }
            
            Button(action: {  }) {
                AppText("Forgot Password?", style: .titleXtraSmall)
            }
        }
    }
    
    var socialContent: some View {
        VStack(spacing: 16) {
            AppText("or sign in with", style: .instructionStep)
            
            HStack(spacing: 24) {
                SocialIcon(image: .google) {  }
                SocialIcon(image: .facebook) {  }
            }
            
            Button(action: { authCoordinator.push(.register) }) {
                AppText("Don’t have an account? Sign Up", style: .instructionStep)
            }
        }
    }
}

// MARK: - Reusable Components
private struct SocialIcon: View {
    let image: AppImage // Assuming AppImage is your enum
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(appImage: image)
                .resizable()
                .scaledToFit() // Prevents distortion
                .frame(width: 30, height: 30)
        }
    }
}

// MARK: - Preview
struct LoginView_Previews: PreviewProvider {
    
    @StateObject static var themeManager = ThemeManager.create()
    static var loginPresentor = LoginPresentor(
        useCase: AuthUseCase(
            authRepository: AuthRepsitoryImpl(
                authService: AuthServiceImpl(
                    networkManager: NetworkAssembly.assemble(
                        environment: .production)))))
    
    static var previews: some View {
        // Mock presenter for preview purposes
        LoginView(
            presentor: loginPresentor)
    }
}
