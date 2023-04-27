//
//  WelcomePresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation

protocol WelcomePresenterProtocol {
    
    func createAnAccount()
    func signIn()
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
    
    func createAnAccount() {
        router.openSignInPage()
    }
    
    func signIn() {
        router.signIn()
    }
}
