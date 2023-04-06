//
//  DetailedRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 05.04.23.
//

import Foundation
import UIKit

//protocol DetailedRouterProtocol {
//    func openNextViewController()
//}

class DetailedRouter {
    
    weak var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

//extension DetailedRouter: DetailedRouterProtocol {
//
//    func openNextViewController() {
//        guard let navigationController = self.view?.navigationController else { return }
//        GalleryConfigurator.open(navigationController: navigationController)
//    }
//}
