//
//  AddDataRouterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol AddDataRouterProtocol {
    
    /// <#Description#>
    /// - Parameter viewController: <#viewController description#>
    func popViewController(viewController: AddDataViewController)
    
    /// <#Description#>
    /// - Parameter index: <#index description#>
    func openTabBarController(index: Int)
}
