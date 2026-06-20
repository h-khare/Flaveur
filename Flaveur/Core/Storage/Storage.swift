//
//  Storage.swift
//  Flaveur
//
//  Created by mac on 31/05/26.
//

import Foundation

@propertyWrapper
public struct Storage<T:Codable>{
    
    // MARK: - Properties
    public var key: StorageKeys
    public var defaultValue: T
    private var storage: UserDefaults = .standard
    
    // MARK: - Initializer
    init(key: StorageKeys, defaultValue: T){
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get{
            guard let data = storage.data(forKey: key.rawValue) else {
                return defaultValue
            }
            return (try? JSONDecoder().decode(T.self, from: data)) ?? defaultValue
        }
        set{
            let data = try? JSONEncoder().encode(newValue)
            storage.set(data, forKey: key.rawValue)
        }
    }
}
