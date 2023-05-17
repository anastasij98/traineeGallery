//
//  ProfileRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 08.05.23.
//

import Foundation
import UIKit

protocol ProfileRouterProtocol {
    
    /// Обращение к конфигуратору экрана настроек(Settings) для его открытия 
    func openSettings()
    
    func openTabBarViewController(index: Int)
}

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
