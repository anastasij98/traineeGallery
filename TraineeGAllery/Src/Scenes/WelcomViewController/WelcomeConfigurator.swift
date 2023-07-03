//
//  WelcomeConfigurator.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation
import UIKit

class WelcomeConfigurator {
    
    static func openViewController(navigationController: UINavigationController) {
        let viewController = Self.getViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    static func getViewController() -> WelcomeViewController {
        
        let viewController = WelcomeViewController()
        let router = WelcomeRouter(view: viewController)
        let presenter = WelcomePresenter(router: router)
        
        viewController.presenter = presenter
        return viewController
    }
}
