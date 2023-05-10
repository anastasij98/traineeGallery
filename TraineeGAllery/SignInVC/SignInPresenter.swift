//
//  SignInPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.04.23.
//

import Foundation

protocol SignInPresenterProtocol {
    
    func openGallery()
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
    
    func openGallery() {
        router.openGallery()
    }
}
