//
//  View+Extension.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

//MARK: - Background Extension
extension View{
    func appBackground() -> some View{
        self
            .modifier(BackgroundModifier())
    }
}


extension View{
    
    // MARK: - Hide/Show View
    @ViewBuilder
    func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }
    
    // MARK: - Corner Radius (Specific corners)
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    // MARK: - Shadow with custom parameters
    func customShadow(color: Color = .black.opacity(0.1),
                      radius: CGFloat = 5,
                      x: CGFloat = 0,
                      y: CGFloat = 2) -> some View {
        self.shadow(color: color, radius: radius, x: x, y: y)
    }
    
    // MARK: - Read Size
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: SizePreferenceKey.self,
                               value: geometry.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
    
    // MARK: - Read Frame in Coordinate Space
    func readFrame(in space: CoordinateSpace,
                   onChange: @escaping (CGRect) -> Void) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: FramePreferenceKey.self,
                               value: geometry.frame(in: space))
            }
        )
        .onPreferenceChange(FramePreferenceKey.self, perform: onChange)
    }
    
    // MARK: - Gradient Background
    func gradientBackground(colors: [Color],
                            startPoint: UnitPoint = .topLeading,
                            endPoint: UnitPoint = .bottomTrailing) -> some View {
        self.background(
            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
        )
    }
    
    // MARK: - End Editing (Dismiss Keyboard)
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                      to: nil, from: nil, for: nil)
    }
    
    // MARK: - Navigation Bar Customization
    func navigationBarColor(backgroundColor: Color? = nil,
                           titleColor: Color? = nil) -> some View {
        modifier(NavigationBarModifier(backgroundColor: backgroundColor,
                                      titleColor: titleColor))
    }
    
    // MARK: - Loading Overlay
    func loadingOverlay(isLoading: Bool,
                        message: String? = nil) -> some View {
        modifier(LoadingOverlayModifier(isLoading: isLoading,
                                       message: message))
    }
}

import SwiftUI

struct GlobalNavigationDisplayModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .navigationBar)
    }
}

// Extend View to make it easily chainable
extension View {
    func hideNavigationBarGlobally() -> some View {
        self.modifier(GlobalNavigationDisplayModifier())
    }
}

// MARK: - Preference Keys
struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

// MARK: - Custom Shape for Corner Radius
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                               byRoundingCorners: corners,
                               cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// MARK: - Navigation Bar Modifier
struct NavigationBarModifier: ViewModifier {
    let backgroundColor: Color?
    let titleColor: Color?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                let appearance = UINavigationBarAppearance()
                
                if let backgroundColor = backgroundColor {
                    appearance.backgroundColor = UIColor(backgroundColor)
                }
                
                if let titleColor = titleColor {
                    appearance.titleTextAttributes = [.foregroundColor: UIColor(titleColor)]
                    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(titleColor)]
                }
                
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().compactAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            }
    }
}

// MARK: - Loading Overlay Modifier
struct LoadingOverlayModifier: ViewModifier {
    let isLoading: Bool
    let message: String?
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if isLoading {
                        ZStack {
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()
                            
                            VStack(spacing: 16) {
                                ProgressView()
                                    .scaleEffect(1.5)
                                    .tint(.white)
                                
                                if let message = message {
                                    Text(message)
                                        .foregroundColor(.white)
                                        .font(.system(size: 14, weight: .medium))
                                }
                            }
                            .padding(24)
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(12)
                        }
                    }
                }
            )
    }
}

// MARK: - View Extension Hierarchy
extension View {
    /// Appends keyboard layouts, auto-capitalization variants, and auto-correct adjustments globally tailored to individual inputs.
    func applyFieldAttributes(_ type: AppFieldType) -> some View {
        self.keyboardType(type.keyboardType)
            .textInputAutocapitalization(type.autoCapitalization)
            .autocorrectionDisabled(type == .email)
    }
}

extension View {
    /// Two-way sync binding utility pattern bridging native focus values out into independent architecture managers safely
    func synchronize<Value: Equatable>(_ first: Binding<Value>, with second: FocusState<Value>.Binding) -> some View {
        self
            .onChange(of: first.wrappedValue) { second.wrappedValue = $0 }
            .onChange(of: second.wrappedValue) { first.wrappedValue = $0 }
    }
}
