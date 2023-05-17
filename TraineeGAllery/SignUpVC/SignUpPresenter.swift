//
//  SignInPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation

protocol SignUpPresenterProtocol {
    
    /// Обращение к роутеру для открытия экрана SigIn
    func onSignInButtonTap()
}

class SignUpPresenter {
    
    weak var view: SignUpViewProtocol?
    var router: SignUpRouterProtocol
    
    init(view: SignUpViewProtocol? = nil,
         router: SignUpRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension SignUpPresenter: SignUpPresenterProtocol {
    
    func onSignInButtonTap() {
        router.openSignInViewController()
    }
}
