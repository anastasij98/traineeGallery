//
//  AddPhotoRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit

protocol AddPhotoRouterProtocol {
    
    func onNextButtonTap(imageObject: Data)
    func openImagePicker(view: AddPhotoViewController)
}

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
    
    func openImagePicker(view: AddPhotoViewController) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = view
        view.present(imagePickerController, animated: true)
    }
}
