//
//  OnboardDIContainer.swift
//  Flaveur
//
//  Created by mac on 05/04/26.
//

import Foundation

final class OnboardDIContainer: ObservableObject{
    
    //MARK: - Properties
    lazy var onboardCoordinatorPresentor: OnboardCoordinatorPresentor = {
        OnboardCoordinatorPresentor(onboardDIContainer: self)
    }()
    
    lazy var makeFirstOnboardPresentor: OnBoardingPresentor = {
        OnBoardingPresentor()
    }()
    
    lazy var makePreferencePresentor: PreferencePresentor = {
        PreferencePresentor()
    }()
    
    //MARK: - functions
}
