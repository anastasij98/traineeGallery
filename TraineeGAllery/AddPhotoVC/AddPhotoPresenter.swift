//
//  AddPhotoPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation

protocol AddPhotoPresenterProtocol {
    
    func addData()
}

class AddPhotoPresenter {
    
    weak var view: AddPhotoVCProtocol?
    var router: AddPhotoRouterProtocol
    
    init(view: AddPhotoVCProtocol? = nil,
         router: AddPhotoRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension AddPhotoPresenter: AddPhotoPresenterProtocol {
    
    func addData() {
        router.addData()
    }
}
