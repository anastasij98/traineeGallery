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
        let network = NetworkService()
        let router = MainRouter(view: viewController)
        let presenter = MainPresenter(view: viewController,
                                         router: router,
                                         network: network)
        viewController.presenter = presenter
        
        return viewController
    }
}

/*
 configurator - собирает все воедино
 view <---> presenter --> router
 router - открывает следующий экран, обращаясь к его (нового экрана) конфигуратору
 */
