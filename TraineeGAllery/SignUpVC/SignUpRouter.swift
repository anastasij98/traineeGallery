//
//  SignInRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation
import UIKit

protocol SignUpRouterProtocol {
    
    /// Обращение к роутеру для получения и открытия экрана SignIn
    func openSignInViewController()
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
}
