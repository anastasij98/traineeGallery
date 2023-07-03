//
//  AddDataRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 11.06.23.
//

import Foundation
import UIKit

class AddDataRouter {
    
    weak var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension AddDataRouter: AddDataRouterProtocol {
    
    func popViewController(viewController: AddDataViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func openTabBarController(index: Int) {
        self.view?.tabBarController?.selectedIndex = index
    }
}
