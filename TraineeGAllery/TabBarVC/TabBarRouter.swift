//
//  TabBarRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit

protocol TabBarRouterProtocol {
    
    
}

class TabBarRouter {
    
    weak var view: TabBarVCProtocol?
    
    init(view: TabBarVCProtocol? = nil) {
        self.view = view
    }
}

extension TabBarRouter: TabBarRouterProtocol {
    

}
