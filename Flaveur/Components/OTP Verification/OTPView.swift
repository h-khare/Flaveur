//
//  OTPView.swift
//  Flaveur
//
//  Created by mac on 09/05/26.
//

import SwiftUI

struct OTPView: View {
    
    //MARK: - Properties
    
    @Environment(\.theme) var theme
    @Binding var otp: String
    @FocusState private var isKeyboardVisible: Bool
    let otpLength = 6
    @State private var animate = false
    
    //MARK: - Body
    
    var body: some View {
        
        ZStack {
            
            // Hidden TextField
            TextField(
                "",
                text: Binding(
                    get: {
                        otp
                    },
                    set: { newValue in
                        let filtered = newValue.filter(\.isNumber)
                        otp = String(filtered.prefix(otpLength))
                    }
                )
            )
            .keyboardType(.numberPad)
            .textContentType(.oneTimeCode)
            .focused($isKeyboardVisible)
            .opacity(0.01)
            .frame(width: 1, height: 1)
            contentView()
                .onTapGesture {
                    isKeyboardVisible = true
                }
        }
        .onAppear {
            isKeyboardVisible = true
            animate = true
        }
    }
}

//MARK: - Extension OTPView

extension OTPView {
    
    /// Content View
    ///
    private func contentView() -> some View {
        
        HStack(spacing: 15) {
            ForEach(0..<otpLength, id: \.self) { index in
                otpBox(at: index)
                    .offset(x: animate ? 0 : 100)
                    .opacity(animate ? 1 : 0)
                    .animation(
                        .easeOut(duration: 0.4)
                        .delay(Double(index) * 0.1),
                        value: animate
                    )
            }
        }
    }
    
    /// OTP Box
    ///
    @ViewBuilder
    private func otpBox(at index: Int) -> some View {
        let character = characterIn(index)
        AppText(
            character.isEmpty ? "0" : character,
            style: .titleMedium,
            color: character.isEmpty
            ? .lightGreen
            : .textPrimary
        )
        .frame(width: 38, height: 38, alignment: .center)
        .multilineTextAlignment(.center)
        .background(
            RoundedRectangle(cornerRadius: 100)
                .stroke(
                    index == otp.count
                    ? theme.colors.primary
                    : theme.colors.primary.opacity(0.5),
                    lineWidth: 1.0
                )
        )
        .cornerRadius(100, corners: .allCorners)
    }
    
    /// Character At Index
    ///
    private func characterIn(_ index: Int) -> String {
        
        guard index < otp.count else {
            return ""
        }
        
        let stringIndex = otp.index(
            otp.startIndex,
            offsetBy: index
        )
        
        return String(otp[stringIndex])
    }
}

//MARK: - Preview
