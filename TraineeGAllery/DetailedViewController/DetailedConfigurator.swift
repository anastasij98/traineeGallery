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
        let server = DetailedNetwork(model: model)
        let presenter = DetailedPresenter(view: viewController, server: server)
        viewController.presenter = presenter
        server.presenter = presenter
        
        return viewController
    }
}
