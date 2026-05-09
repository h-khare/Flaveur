//
//  AppField.swift
//  Flaveur
//
//  Created by mac on 11/04/26.
//

import SwiftUI

struct AppField: View {
    
    //MARK: - Properties
    @State var text:String = ""
    
    //MARK: - Body
    var body: some View {
        TextField(text: $text) {
            TextView()
        }
    }
}

#Preview {
    AppField()
}
