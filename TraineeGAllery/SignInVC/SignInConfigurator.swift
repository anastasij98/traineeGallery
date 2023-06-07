//
//  SignInConfigurator.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.04.23.
//

import Foundation
import UIKit

class SignInConfigurator {
    
    static func open(navigationController: UINavigationController) {
        let viewController = Self.getViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    static func getViewController() -> SignInViewController {
        let viewController = SignInViewController()
        let network = NetworkService()
        let userDefaultsService = UserDefaultsService()
        let router = SignInRouter(view: viewController)
        let presenter = SignInPresenter(view: viewController,
                                        router: router,
                                        network: network,
                                        userDefaultsService: userDefaultsService)
        viewController.presenter = presenter
        
        return viewController
    }
}
