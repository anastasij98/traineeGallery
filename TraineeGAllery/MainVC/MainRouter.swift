//
//  MainRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 04.04.23.
//

import Foundation
import UIKit

class MainRouter {
 
    weak var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension MainRouter: MainRouterProtocol {
    
    func openDetailedViewController(model: ItemModel) {
        guard let navigationController = self.view?.navigationController else { return } 
        DetailedConfigurator.openViewController(navigationController: navigationController,
                                                model: model)
    }
}
