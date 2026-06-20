//
//  Coordinator.swift
//  Flaveur
//
//  Created by mac on 05/04/26.
//

import SwiftUI

protocol Coordinator{
    
    //MARK: - Properties
    var routes: NavigationPath { get set }
    
    associatedtype Router: Hashable
    
    //MARK: - Functions
    func push(_ route: Router)
    func pop()
    func build(_ route: Router) -> AnyView
    func popToRoot()
}
