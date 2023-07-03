//
//  ProfileRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 08.05.23.
//

import Foundation
import UIKit

class ProfileRouter {
    
    weak var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension ProfileRouter: ProfileRouterProtocol {
    
    func openSettings() {
        guard let viewController = self.view?.navigationController else { return }
        SettingsConfigurator.openViewController(navigationController: viewController)
    }
    
    func openTabBarViewController(index: Int) {
        self.view?.tabBarController?.selectedIndex = index
    }
}
