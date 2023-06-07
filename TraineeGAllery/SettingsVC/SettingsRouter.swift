//
//  SettingsRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.05.23.
//

import Foundation
import UIKit

protocol SettingsRouterProtocol {
    
    func popViewController(viewController: SettingsViewController)
    func returnToWelcomeViewController()
}

class SettingsRouter {
    
    weak var view: UIViewController?
    init(view: UIViewController? = nil) {
        self.view = view
    }
}


extension SettingsRouter: SettingsRouterProtocol {
    
    func popViewController(viewController: SettingsViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func returnToWelcomeViewController() {
        guard let navigationController = self.view?.navigationController else { return }
        WelcomeConfigurator.openViewController(navigationController: navigationController)
    }
}
