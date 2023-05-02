//
//  SignInRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation
import UIKit

protocol SignUpRouterProtocol {
    
    func signIn()
}

class SignUpRouter {
 
    weak var view: UIViewController?
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension SignUpRouter: SignUpRouterProtocol {
    
    func signIn() {
        guard let navigationController = self.view?.navigationController else { return }
        SignInConfigurator.open(navigationController: navigationController)
    }

}
