//
//  WelcomeRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation
import UIKit

protocol WelcomeRouterProtocol {
    
    func openSignInPage()
    func signIn()
}

class WelcomeRouter {
    
    weak var view: UIViewController?
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension WelcomeRouter: WelcomeRouterProtocol {
    
    func openSignInPage() {
        guard let navigationController = self.view?.navigationController else { return }
        SignUpConfigurator.openViewController(navigationController: navigationController)
    }
    
    func signIn() {
        guard let navigationController = self.view?.navigationController else { return }
        SignInConfigurator.open(navigationController: navigationController)
    }
}
