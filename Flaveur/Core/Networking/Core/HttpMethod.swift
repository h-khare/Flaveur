//
//  HttpMethod.swift
//  Flaveur
//
//  Created by mac on 23/05/26.
//

import Foundation

//MARK: - HttpMethod
public enum HttpMethod: String, CaseIterable{
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
}
