//
//  SignInRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.04.23.
//

import Foundation
import UIKit

protocol SignInRouterProtocol {
    
    /// Получение и открытие экрана с TabBarController'ом
    func openTabBarController()
    
    /// Закрытие экрна SignIn
    /// - Parameter viewController: SignIn
    func popViewController(viewController: SignInViewController)
}

class SignInRouter {
    
    weak var view: UIViewController?
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension SignInRouter: SignInRouterProtocol {
    
    func openTabBarController() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = windowScenes?.windows.first
        window?.rootViewController = TabBarConfigurator.getViewController()
    }
    
    func popViewController(viewController: SignInViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
}
