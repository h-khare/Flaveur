//
//  CountryPickerView.swift
//  Flaveur
//
//  Created by mac on 12/04/26.
//

import SwiftUI

struct CountryPickerView: View {
    @ObservedObject var service: CountryService
    var onSelect: (Country) -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List(service.filteredCountries, id: \.code) { country in
                Button {
                    onSelect(country)
                    dismiss()
                } label: {
                    HStack {
                        Text(country.flag)
                        Text(country.name)
                        Spacer()
                        Text(country.dialCode)
                            .foregroundColor(.gray)
                    }
                }
            }
            .searchable(text: $service.searchText, prompt: "Search Country")
            .navigationTitle("Select Country")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
