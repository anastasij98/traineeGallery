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
        let network = NetworkService()
        let presenter = DetailedPresenter(view: viewController,
                                          network: network,
                                          model: model)
        viewController.presenter = presenter
        
        return viewController
    }
}
