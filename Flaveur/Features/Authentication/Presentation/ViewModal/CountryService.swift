//
//  CountryService.swift
//  Flaveur
//
//  Created by mac on 12/04/26.
//

import Foundation
class CountryService: ObservableObject {
    @Published var countries: [Country] = []
    @Published var searchText: String = ""
    
    var filteredCountries: [Country] {
        if searchText.isEmpty { return countries }
        return countries.filter { ($0.name).lowercased().contains(searchText.lowercased()) || ($0.dialCode).contains(searchText) }
    }
    
    init() {
        guard let country:[Country] = Bundle.main.decode("country.json") else {
            self.countries = []
            return
        }
        self.countries = country
    }
}
