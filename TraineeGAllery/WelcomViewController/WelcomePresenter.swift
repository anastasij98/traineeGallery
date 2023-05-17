//
//  WelcomePresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation

protocol WelcomePresenterProtocol {
    
    /// Открытие экрана SignUp для регистрации пользователя
    func onSignUpButtonTap()
    
    /// Открытие экрана SignIn для авторизации пользователя
    func onSignInButtonTap()
}

class WelcomePresenter {
    
    weak var view: WelcomeViewControllerProtocol?
    var router: WelcomeRouterProtocol
    
    init(view: WelcomeViewControllerProtocol? = nil,
         router: WelcomeRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension WelcomePresenter: WelcomePresenterProtocol {
    
    func onSignUpButtonTap() {
        router.openSignUpPage()
    }
    
    func onSignInButtonTap() {
        router.openSignInPage()
    }
}
