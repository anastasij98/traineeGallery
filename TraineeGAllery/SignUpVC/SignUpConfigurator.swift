//
//  SignInConfigurator.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation
import UIKit

class SignUpConfigurator {
    
    static func openViewController(navigationController: UINavigationController) {
        let viewController = Self.getViewController()
        navigationController.pushViewController(viewController, animated: true)
    }

    static func getViewController() -> SignUpViewController {
        let viewController = SignUpViewController()
        let router = SignUpRouter(view: viewController)
        let presenter = SignUpPresenter(view: viewController,
                                        router: router)
        viewController.presenter = presenter

        return viewController
    }
}
