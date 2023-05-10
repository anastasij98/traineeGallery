//
//  ProfilePresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 08.05.23.
//

import Foundation

protocol ProfilePresenterProtocol {
    
    func openSettings()
}

class ProfilePresenter {
    
    weak var view: ProfileVCProtocol?
    var router: ProfileRouterProtocol
    
    init(view: ProfileVCProtocol? = nil,
         router: ProfileRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    
    func openSettings() {
        router.openSettings()
    }

}
