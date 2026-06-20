//
//  AppUtility.swift
//  Flaveur
//
//  Created by mac on 12/04/26.
//

import Foundation

final class AppUtility{
    
    //MARK: - Properties
    static var shared = AppUtility()
    
    func getCountries() -> [Country] {
        guard let countries:CountryEntity = Bundle.main.decode("country.json") else {
            return []
        }
        return countries.countries
    }
}
