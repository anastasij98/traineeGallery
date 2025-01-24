//
//  AddPhotoRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit

class AddPhotoRouter {
    
    weak var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension AddPhotoRouter: AddPhotoRouterProtocol {
    
    func onNextButtonTap(imageObject: Data) {
        guard let navigationController = self.view?.navigationController else { return }
        AddDataConfigurator.openViewController(navigationController: navigationController,
                                               imageObject: imageObject)
    }
    
    func openImagePicker(viewController: AddPhotoViewController) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = viewController
        viewController.present(imagePickerController, animated: true)
    }
}
