//
//  AddPhotoRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit

protocol AddPhotoRouterProtocol {
    
    func addData()
}

class AddPhotoRouter {
    
    weak var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension AddPhotoRouter: AddPhotoRouterProtocol {
    
    func addData() {
        guard let navigationController = self.view?.navigationController else { return }
        AddDataConfigurator.openViewController(navigationController: navigationController)
    }
}
