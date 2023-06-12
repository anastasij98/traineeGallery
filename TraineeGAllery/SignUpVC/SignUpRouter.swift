//
//  SignInRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation
import UIKit

protocol SignUpRouterProtocol {
    
    /// Получение и открытие экрана SignIn
    func openSignInViewController()
    
    /// Открытие TabBarController'a
    func openTabBarController()
    
    /// Закрытие экрана SignUp
    /// - Parameter viewController: экран SignUp
    func popViewController(viewController: SignUpViewController)
}

class SignUpRouter {
 
    weak var view: UIViewController?
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension SignUpRouter: SignUpRouterProtocol {
    
    func openSignInViewController() {
        guard let navigationController = self.view?.navigationController else { return }
        SignInConfigurator.open(navigationController: navigationController)
    }
    
    func openTabBarController() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = windowScenes?.windows.first
        window?.rootViewController = TabBarConfigurator.getViewController()
    }
    
    func popViewController(viewController: SignUpViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
}
