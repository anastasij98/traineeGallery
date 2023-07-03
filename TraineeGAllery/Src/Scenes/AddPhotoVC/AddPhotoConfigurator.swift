//
//  AddPhotoConfigurator.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit

class AddPhotoConfigurator {
    
    static func openViewController(navigationController: UINavigationController) {
        let viewController = Self.getViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    static func getViewController() -> AddPhotoViewController {
        let viewController = AddPhotoViewController()
        let router = AddPhotoRouter(view: viewController)
        let presenter = AddPhotoPresenter(view: viewController,
                                          router: router)
        viewController.presenter = presenter
        
        return viewController
    }
}
