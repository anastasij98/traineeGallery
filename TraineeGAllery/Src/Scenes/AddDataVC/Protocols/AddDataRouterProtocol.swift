//
//  AddDataRouterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol AddDataRouterProtocol {
    
    /// Закрытие AddDataViewController'a
    func popViewController(viewController: AddDataViewController)
    
    /// Открытие viewController'a по выбранному индексу, который находится в tabBarContriller'e
    func openTabBarController(index: Int)
}
