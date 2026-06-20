//
//  AuthCoordinatorView.swift
//  Flaveur
//
//  Created by mac on 24/05/26.
//

import SwiftUI

struct AuthCoordinatorView: View {
    
    // MARK: - Properties
    @EnvironmentObject private var authPresentor: AuthCoordinatorPresentor
    
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $authPresentor.routes) {
            authPresentor.build(.login)
                .toolbar(.hidden, for: .navigationBar)
                .navigationDestination(for: AuthRoutes.self) { route in
                    authPresentor.build(route)
                        .navigationBarTitleDisplayMode(.inline)
                }
        }.environmentObject(authPresentor)
    }
}

#Preview {
    AuthCoordinatorView()
}
