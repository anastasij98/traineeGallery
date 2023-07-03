//
//  TabBarPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation

protocol TabBarPresenterProtocol {
    
    
}

class TabBarPresenter {
    
    weak var view: TabBarVCProtocol?
    var router: TabBarRouterProtocol
    
    init(view: TabBarVCProtocol? = nil,
         router: TabBarRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension TabBarPresenter: TabBarPresenterProtocol {
     
    
}
