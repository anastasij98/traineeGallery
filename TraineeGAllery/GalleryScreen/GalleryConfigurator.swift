//
//  GalleryConfigurator.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 04.04.23.
//

import Foundation
import UIKit

class GalleryConfigurator {
    
    static func open(navigationController: UINavigationController) {
        let viewController = Self.getViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    static func getViewController() -> ViewController {
        let viewController = ViewController()
        let router = GalleryRouter(view: viewController)
        let presenter = GalleryPresenter(view: viewController, router: router)
        viewController.presenter = presenter
        
        return viewController
    }
}

/*
 configurator - собирает все воедино
 view <---> presenter --> router
 router - открывает следующий экран, обращаясь к его (нового экрана) конфигуратору
 */
