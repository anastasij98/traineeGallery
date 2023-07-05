//
//  MainConfigurator.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 04.04.23.
//

import Foundation
import UIKit

class MainConfigurator {
    
    static func open(navigationController: UINavigationController) {
        let viewController = Self.getViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    static func getViewController() -> MainViewController {
        let viewController = MainViewController()
        let router = MainRouter(view: viewController)
        let presenter = MainPresenter(view: viewController,
                                      router: router,
                                      fileUseCase: DI.resolve())
        viewController.presenter = presenter
        
        return viewController
    }
}
