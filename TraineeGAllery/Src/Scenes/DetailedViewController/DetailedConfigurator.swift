//
//  DetailedConfigurator.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 05.04.23.
//

import Foundation
import UIKit

class DetailedConfigurator {
    
    static func openViewController(navigationController: UINavigationController, model: ItemModel) {
        let viewController = Self.getViewController(model: model)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    static func getViewController(model: ItemModel) -> DetailedViewController {
        let viewController = DetailedViewController()
        let presenter = DetailedPresenter(view: viewController,
                                          model: model,
                                          fileUseCase: DI.resolve())
        viewController.presenter = presenter
        
        return viewController
    }
}
