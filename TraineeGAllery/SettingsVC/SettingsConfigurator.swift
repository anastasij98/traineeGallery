//
//  SettingsConfigurator.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 08.05.23.
//

import Foundation
import UIKit

class SettingsConfigurator {
    
    static func openViewController(navigationController: UINavigationController) {
        let viewController = Self.getViewController()
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
    
    static func getViewController() -> SettingsViewController {
        let viewController = SettingsViewController()
        let userDef = UserDefaultsService()
        let network = NetworkService()
        let router = SettingsRouter(view: viewController)
        let presenter = SettingsPresenter(view: viewController,
                                          router: router,
                                          userDef: userDef,
                                          network: network)
        viewController.presenter = presenter
        
        return viewController
    }
}
