//
//  WelcomeRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation
import UIKit

class WelcomeRouter {
    
    weak var view: UIViewController?
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension WelcomeRouter: WelcomeRouterProtocol {
    
    func openSignUpPage() {
        guard let navigationController = self.view?.navigationController else { return }
        SignUpConfigurator.openViewController(navigationController: navigationController)
    }
    
    func openSignInPage() {
        guard let navigationController = self.view?.navigationController else { return }
        SignInConfigurator.open(navigationController: navigationController)
    }
}
