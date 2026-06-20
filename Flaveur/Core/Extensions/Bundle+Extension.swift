//
//  Bundle+Extension.swift
//  Flaveur
//
//  Created by mac on 12/04/26.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T? {
        // 1. Locate the file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            print("Failed to locate \(file) in bundle.")
            return nil
        }

        // 2. Load the data
        guard let data = try? Data(contentsOf: url) else {
           print("Failed to load \(file) from bundle.")
            return nil
        }

        // 3. Decode the data
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Failed to decode \(file): \(error.localizedDescription)")
            return nil
        }
    }
}
