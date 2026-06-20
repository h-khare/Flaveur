//
//  OnBoardingPresentor.swift
//  Flaveur
//
//  Created by mac on 05/04/26.
//

import Foundation

enum OnboardingSteps: String, CaseIterable {
    case FIRST_SCREEN
    case SECOND_SCREEN
}

//MARK: - OnBoardingPresentor
final class OnBoardingPresentor: ObservableObject{
    
    //MARK: - Properties
    @Published var currentStep: OnboardingSteps = .FIRST_SCREEN
    
    //MARK: - Functions
    
}
