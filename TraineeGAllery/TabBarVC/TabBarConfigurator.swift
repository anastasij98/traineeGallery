//
//  TabBarConfigurator.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit

class TabBarConfigurator {
    
    static func openViewController(navigationController: UINavigationController) {
        let viewController = Self.getViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    static func getViewController() -> TabBarViewController {
        let viewController = TabBarViewController()
        let router = TabBarRouter(view: viewController)
        let presenter = TabBarPresenter(view: viewController,
                                        router: router)
        viewController.presenter = presenter
        
        return viewController
    }
}
