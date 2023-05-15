//
//  AddPhotoRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit

protocol AddPhotoRouterProtocol {
    
    func addButtonTapped(imageName: String)
    func openImagePicker(view: AddPhotoViewController)
}

class AddPhotoRouter {
    
    weak var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension AddPhotoRouter: AddPhotoRouterProtocol {
    
    func addButtonTapped(imageName: String) {
        guard let navigationController = self.view?.navigationController else { return }
        AddDataConfigurator.openViewController(navigationController: navigationController,
                                               imageName: imageName)
    }
    
    func openImagePicker(view: AddPhotoViewController) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = view
        view.present(imagePickerController, animated: true)
        
    }
    
    
}
