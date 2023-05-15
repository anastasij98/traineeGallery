//
//  AddDataConfigurator.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit

class AddDataConfigurator {
    
    static func openViewController(navigationController: UINavigationController,
                                   imageName: String) {
        let viewController = Self.getViewController(imageName: imageName)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    static func getViewController(imageName: String) -> AddDataViewController {
        let viewController = AddDataViewController()
        viewController.imageName = imageName
        
        return viewController
    }
}
