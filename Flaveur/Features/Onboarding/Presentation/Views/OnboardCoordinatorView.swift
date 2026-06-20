//
//  OnboardCoordinatorView.swift
//  Flaveur
//
//  Created by mac on 05/04/26.
//

import SwiftUI

struct OnboardCoordinatorView: View {
    
    // MARK: - Properties
    @EnvironmentObject var onboardCoordinatorPresentor: OnboardCoordinatorPresentor
    
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $onboardCoordinatorPresentor.routes) {
            onboardCoordinatorPresentor.build(.onboardFirst)
                .navigationDestination(for: OnboardRoute.self) { route in
                    onboardCoordinatorPresentor.build(route)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar(.hidden, for: .navigationBar)
                }
        }
        .scrollContentBackground(.hidden)
    }
}

