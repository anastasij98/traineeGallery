//
//  SignInPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.04.23.
//

import Foundation

protocol SignInPresenterProtocol {
    
    /// Обращение к роутеру для открытия экрана с TabBarController'ом
    func openTabBar()
}

class SignInPresenter {
    
    weak var view: SignInViewProtocol?
    var router: SignInRouterProtocol
    
    init(view: SignInViewProtocol? = nil,
         router: SignInRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension SignInPresenter: SignInPresenterProtocol {
    
    func openTabBar() {
        router.openTabBarController()
    }
}
