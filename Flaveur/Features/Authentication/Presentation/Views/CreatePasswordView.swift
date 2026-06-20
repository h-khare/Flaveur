//
//  CreatePasswordView.swift
//  Flaveur
//
//  Created by mac on 10/05/26.
//

import SwiftUI

struct CreatePasswordView: View {
    
    //MARK: - Properties
    @Environment(\.theme) var theme
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State private var animate = false
    
    //MARK: - Body
    var body: some View {
        ZStack{
            content()
        }
        .appBackground()
    }
}

//MARK: - Extension CreatePasswordView
extension CreatePasswordView{
    
    /// Content View
    ///
    private func content() -> some View{
        VStack(spacing: 50){
            AppText("Create Password", style: .recipeTitle)
            ScrollView(showsIndicators: false){
                emailContent()
            }
            .padding(.horizontal,36)
            button("Continue") {
            }
        }.padding(.bottom, 20)
    }
    
    private func emailContent() -> some View {
        VStack(spacing: 20){
            
//            AppText("Create a new password", style: .recipeTitle)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .offset(x: animate ? 0 : 100)
//                .opacity(animate ? 1 : 0)
//                .animation(.easeOut(duration: 0.4).delay(0.1), value: animate)
//            
//            AppText("Enter your new password. If you forgot it then you have to do the step of forgot password.", style: .labelRegular)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .offset(x: animate ? 0 : 100)
//                .opacity(animate ? 1 : 0)
//                .animation(.easeOut(duration: 0.4).delay(0.3), value: animate)
//            
//            VStack(spacing: 8){
//                AppTextField(text: $password, name: "New Password", placeholder: "Enter new password", type: .password, rules: [.required,.minLength(6), .maxLength(14), .password])
//                    .offset(x: animate ? 0 : 100)
//                    .opacity(animate ? 1 : 0)
//                    .animation(.easeOut(duration: 0.4).delay(0.5), value: animate)
//                
//                AppTextField(text: $confirmPassword, 
//                             name: "Confirm Password",
//                             placeholder: "Confirm password",
//                             type: .password,
//                             rules: [.required, .minLength(6), .maxLength(14), .confirmPassword(password)])
//                    .offset(x: animate ? 0 : 100)
//                    .opacity(animate ? 1 : 0)
//                    .animation(.easeOut(duration: 0.4).delay(0.5), value: animate)
//            }
//            .padding(.top, 20)
        }
        .onAppear {
            animate = true
        }
    }
    
    /// Common Button Component
    ///
    private func button(_ text: String, callback: @escaping () -> Void) -> some View{
        Button{
            callback()
        } label: {
            AppText(text, style: .recipeTitle, color: theme.colors.vegan)
                .padding(.vertical,12)
                .padding(.horizontal, 57)
                .background(.primaryLight)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
    }
}

#Preview {
    CreatePasswordView()
}
