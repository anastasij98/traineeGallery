//
//  TabBarRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit

protocol TabBarRouterProtocol { }

class TabBarRouter {
    
    weak var view: TabBarViewController?
    
    init(view: TabBarViewController? = nil) {
        self.view = view
    }
}

extension TabBarRouter: TabBarRouterProtocol {
    
    func popTabBar(viewVC: TabBarViewController) {
        guard let navigationController = self.view?.navigationController else { return }
        viewVC.navigationController?.popViewController(animated: true)
    }
}
