//
//  AuthCoordinatorVM.swift
//  Flaveur
//
//  Created by mac on 04/04/26.
//

import Foundation

//MARK: - AppFlow
enum AppFlow: String, CaseIterable{
    case SPLASH = "Splash"
    case ON_BOARDING = "On Boarding"
    case AUTH = "Auth"
    case MAIN = "Main"
}


//MARK: - AppCoordinatorPresentor
final class AppCoordinatorPresentor: ObservableObject{
    
    //MARK: - Properties
    @Published var appFlow: AppFlow = .ON_BOARDING
}
