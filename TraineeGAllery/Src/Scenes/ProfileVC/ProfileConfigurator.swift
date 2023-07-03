//
//  ProfileConfigurator.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit

class ProfileConfigurator {
    
    static func openViewController(navigationController: UINavigationController) {
        let viewController = Self.getViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    static func getViewController() -> ProfileViewController {
        let viewController = ProfileViewController()
        let network = NetworkService()
        let userDef = UserDefaultsService()
        let router = ProfileRouter(view: viewController)
        let presenter = ProfilePresenter(view: viewController,
                                         router: router,
                                         network: network,
                                         userDef: userDef)
        viewController.presenter = presenter
        
        return viewController
    }
}
