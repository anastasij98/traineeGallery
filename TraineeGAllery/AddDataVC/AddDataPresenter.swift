//
//  AddDataPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 11.06.23.
//

import Foundation

protocol AddDataPresenterProtocol {
    
    func popViewController(viewController: AddDataViewController)
}

class AddDataPresenter {
    
    weak var view: AddDataVCProtocol?
    var router: AddDataRouterProtocol
    
    init(view: AddDataVCProtocol? = nil,
         router: AddDataRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension AddDataPresenter: AddDataPresenterProtocol {
    
    func popViewController(viewController: AddDataViewController) {
        router.popViewController(viewController: viewController)
    }
}
