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
                                   imageObject: Data) {
        let viewController = Self.getViewController(imageObject: imageObject)
        navigationController.pushViewController(viewController, animated: true)
    }

    static func getViewController(imageObject: Data) -> AddDataViewController {
        let viewController = AddDataViewController()
        viewController.imageObject = imageObject

        return viewController
    }
}
