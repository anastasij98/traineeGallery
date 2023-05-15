//
//  AddPhotoPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation

protocol AddPhotoPresenterProtocol {
    
    func onNextButtonTap()
    func getItemsCount() -> Int
    func getItem(withIndex index: Int) -> ImageObjectModel
    func didSelectItem(withIndex index: Int)
    func openImagePicker(view: AddPhotoViewController)
}

class AddPhotoPresenter {
    
    weak var view: AddPhotoVCProtocol?
    var router: AddPhotoRouterProtocol
    
    var imageNames: [String] = ["cat1", "cat2", "cat3", "cat4", "cat5", "cat6"]
    var selectedObject: String?
    
    init(view: AddPhotoVCProtocol? = nil,
         router: AddPhotoRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension AddPhotoPresenter: AddPhotoPresenterProtocol {
    
    func getItemsCount() -> Int {
        imageNames.count
    }
    
    func getItem(withIndex index: Int) -> ImageObjectModel {
        ImageObjectModel(imageName: imageNames[index])
    }
    
    func didSelectItem(withIndex index: Int) {
        let imageName = imageNames[index]
        view?.setSelectedImage(model: ImageObjectModel(imageName: imageName))
        selectedObject = imageName
    }
    
    
    func onNextButtonTap() {
        guard let selectedObject = selectedObject else { return }
        router.addButtonTapped(imageName: selectedObject)
    }
    
    func openImagePicker(view: AddPhotoViewController) {
        router.openImagePicker(view: view)
    }
}
