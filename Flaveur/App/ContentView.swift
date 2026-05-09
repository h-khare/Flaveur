//
//  ContentView.swift
//  Flaveur
//
//  Created by mac on 08/03/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            AppText("Headline Large", style: .bodyLarge)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
