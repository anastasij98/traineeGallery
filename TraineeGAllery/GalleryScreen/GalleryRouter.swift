//
//  GalleryRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 04.04.23.
//

import Foundation
import UIKit

protocol GalleryRouterProtocol {
    
    func openDetailedViewController(model: ItemModel)
}

class GalleryRouter {
 
    weak var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension GalleryRouter: GalleryRouterProtocol {
    
    func openDetailedViewController(model: ItemModel) {
        guard let navigationController = self.view?.navigationController else { return }
        let detailedVC = DetailedVC()
        detailedVC.model = model
        navigationController.pushViewController(detailedVC, animated: true)
    }
}
