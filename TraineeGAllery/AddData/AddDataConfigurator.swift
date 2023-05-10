//
//  AddDataConfigurator.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit

class AddDataConfigurator {
    
    static func openViewController(navigationController: UINavigationController) {
        let viewController = Self.getViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    static func getViewController() -> AddDataViewController {
        let viewController = AddDataViewController()
        
        return viewController
    }
}
