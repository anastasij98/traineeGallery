//
//  SignInRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation
import UIKit

protocol SignUpRouterProtocol {
    
    func openGallery()
}

class SignUpRouter {
 
    weak var view: UIViewController?
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension SignUpRouter: SignUpRouterProtocol {
    
    func openGallery() {
        guard let navigationController = self.view?.navigationController else { return }
        GalleryConfigurator.open(navigationController: navigationController)
    }

}
