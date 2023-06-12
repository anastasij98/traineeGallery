//
//  SettingsRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.05.23.
//

import Foundation
import UIKit

protocol SettingsRouterProtocol {
    
    /// Закрытие экрана Settings
    /// - Parameter viewController: viewController, который надо закрыть
    func popViewController(viewController: SettingsViewController)
    
    /// Возвращение на приветственный экран
    func returnToWelcomeViewController()
}

class SettingsRouter {
    
    weak var view: UIViewController?
    init(view: UIViewController? = nil) {
        self.view = view
    }
}


extension SettingsRouter: SettingsRouterProtocol {
    
    func popViewController(viewController: SettingsViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func returnToWelcomeViewController() {
        let welcomeViewController = WelcomeConfigurator.getViewController()
        let navigationController = UINavigationController(rootViewController: welcomeViewController)
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = navigationController
    }
}
