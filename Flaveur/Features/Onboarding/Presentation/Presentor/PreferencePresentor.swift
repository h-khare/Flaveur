//
//  PreferencePresentor.swift
//  Flaveur
//
//  Created by mac on 05/04/26.
//

import Foundation

enum PreferenceSteps: String, CaseIterable {
    case cookingLevel
    case preferences
    case allergic
}

//MARK: - PreferencePresentor
final class PreferencePresentor: ObservableObject{
    
    //MARK: - Properties
    @Published var preferenceStep: PreferenceSteps = .cookingLevel
    @Published var cookingLevels: [CookingLevelModel] = []
    @Published var cuisinesPreference: [CuisinesPreferenceModel] = []
    @Published var selectedLevelId: Int?
    
    init(){
        cookingLevels = [
            CookingLevelModel(id: 1, name: "Beginner", description: "Just starting out"),
            CookingLevelModel(id: 2, name: "Novice", description: "Basic cooking skills"),
            CookingLevelModel(id: 3, name: "Intermediate", description: "Can follow recipes"),
            CookingLevelModel(id: 4, name: "Advanced", description: "Comfortable cooking"),
            CookingLevelModel(id: 5, name: "Expert", description: "Experienced chef"),
            CookingLevelModel(id: 6, name: "Home Cook", description: "Cooks regularly"),
            CookingLevelModel(id: 7, name: "Food Lover", description: "Enjoys cooking & eating"),
            CookingLevelModel(id: 8, name: "Baker", description: "Specializes in baking"),
            CookingLevelModel(id: 9, name: "Grill Master", description: "Loves grilling"),
            CookingLevelModel(id: 10, name: "Professional", description: "Works in kitchen")
        ]
        
        cuisinesPreference = [
            .init(id: 1, name: "Italian", iamge: "italian"),
            .init(id: 2, name: "Chinese", iamge: "chinese"),
            .init(id: 3, name: "Indian", iamge: "indian"),
            .init(id: 4, name: "Mexican", iamge: "mexican"),
            .init(id: 5, name: "Thai", iamge: "thai"),
            .init(id: 6, name: "Japanese", iamge: "japanese"),
            .init(id: 7, name: "Korean", iamge: "korean"),
            .init(id: 8, name: "French", iamge: "french"),
            .init(id: 9, name: "Spanish", iamge: "spanish"),
            .init(id: 10, name: "Greek", iamge: "greek"),
            .init(id: 11, name: "Mediterranean", iamge: "mediterranean"),
            .init(id: 12, name: "American", iamge: "american"),
            .init(id: 13, name: "Vietnamese", iamge: "vietnamese"),
            .init(id: 14, name: "Turkish", iamge: "turkish"),
            .init(id: 15, name: "Lebanese", iamge: "lebanese"),
            .init(id: 16, name: "Brazilian", iamge: "brazilian"),
            .init(id: 17, name: "Caribbean", iamge: "caribbean"),
            .init(id: 18, name: "German", iamge: "german"),
            .init(id: 19, name: "British", iamge: "british"),
            .init(id: 20, name: "African", iamge: "african")
        ]
    }
    
    //MARK: - Functions
    
    
}
