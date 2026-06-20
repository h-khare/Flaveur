//
//  StorageKeys.swift
//  Flaveur
//
//  Created by mac on 31/05/26.
//

import Foundation

public enum StorageKeys: String, CaseIterable{
    case isOnboard
    case isMain
    case userData = "com.flaveur.storage.user.data"
    case token = "com.flaveur.storage.user.token"
    case refreshToken = "com.flaveur.storage.user.refreshToken"
    case isLogin = "com.flaveur.storage.login.status"
}
