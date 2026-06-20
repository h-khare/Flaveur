//
//  ForgotPasswordView.swift
//  Flaveur
//
//  Created by mac on 12/04/26.
//

import SwiftUI

// MARK: - Local Focus Identifiers
enum ForgotPasswordField: Hashable {
    case email
}

struct ForgotPasswordView: View {
    
    // MARK: - Properties
    @Environment(\.theme) var theme
    @State var email: String = ""
    @State private var animate = false
    @State var done: Bool = false
    @State var otp: String = ""
    
    // MARK: - Focus Management Engine
    @FocusState private var activeField: ForgotPasswordField?
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Invisible background layer drops keyboard safely when clicking whitespace
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture { activeField = nil }
            
            content()
        }
        .appBackground()
    }
}

// MARK: - View Layout Components
private extension ForgotPasswordView {
    
    /// Main Layout Organizer
    func content() -> some View {
        VStack(spacing: 50) {
            AppText("Forgot Passwords", style: .recipeTitle)
            
            ScrollView(showsIndicators: false) {
                if done {
                    otpContent()
                } else {
                    emailContent()
                }
            }
            .padding(.horizontal, 36)
            
            // Core Operational Form Trigger
            button(done ? "Verify OTP" : "Continue") {
                // Dismiss keyboard inputs prior to page flips
                activeField = nil
                animate = false

                withAnimation(.easeInOut(duration: 0.3)) {
                    done.toggle()
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    animate = true
                }
            }
        }
        .padding(.bottom, 20)
    }
    
    /// Email Capture Subview
    func emailContent() -> some View {
        VStack(spacing: 20) {
            AppText("Hello There!", style: .recipeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: animate ? 0 : 100)
                .opacity(animate ? 1 : 0)
                .animation(.easeOut(duration: 0.4).delay(0.1), value: animate)
            
            AppText("Enter your email address. We will send a code verification in the next step.", style: .labelRegular)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: animate ? 0 : 100)
                .opacity(animate ? 1 : 0)
                .animation(.easeOut(duration: 0.4).delay(0.3), value: animate)
            
            // Decoupled AppTextField Utilization: Custom Initializer Defaults Handle the rest
            AppTextField(
                text: $email,
                name: "Email",
                placeholder: "Enter email here",
                type: .email,
                fieldIdentity: .email,
                focusState: $activeField,
                isLastField: true // Sets keyboard return button style to "Done"
            )
            .offset(x: animate ? 0 : 100)
            .opacity(animate ? 1 : 0)
            .animation(.easeOut(duration: 0.4).delay(0.5), value: animate)
        }
        .onAppear {
            animate = true
            // Auto-focus email input frame when screen presents
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                activeField = .email
            }
        }
    }
    
    /// OTP Verification Subview
    func otpContent() -> some View {
        VStack(spacing: 20) {
            AppText("You’ve got mail", style: .recipeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: animate ? 0 : 100)
                .opacity(animate ? 1 : 0)
                .animation(.easeOut(duration: 0.4).delay(0.1), value: animate)
            
            AppText("We will send you the verification code to your email address, check your email and put the code right below .", style: .labelRegular)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: animate ? 0 : 100)
                .opacity(animate ? 1 : 0)
                .animation(.easeOut(duration: 0.4).delay(0.3), value: animate)
            
            OTPView(otp: $otp)
                .padding(.vertical, 20)
            
            AppText("Didn’t receive the mail? You can resend it in 49 sec", style: .labelRegular, alignment: .center)
                .frame(width: 180, alignment: .center)
                .offset(x: animate ? 0 : 100)
                .opacity(animate ? 1 : 0)
                .animation(.easeOut(duration: 0.4).delay(0.5), value: animate)
        }
        .onAppear {
            animate = true
        }
    }
    
    /// Modular Custom Button Component
    func button(_ text: String, callback: @escaping () -> Void) -> some View {
        Button {
            callback()
        } label: {
            AppText(text, style: .recipeTitle, color: theme.colors.vegan)
                .padding(.vertical, 12)
                .padding(.horizontal, 57)
                .background(theme.colors.primaryLight) // Fixed explicit token missing dot modifier context
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
    }
}

// MARK: - Canvas Preview
#Preview {
    ForgotPasswordView()
}
