//
//  AddPhotoPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import Photos

class AddPhotoPresenter {
    
    weak var view: AddPhotoVCProtocol?
    var router: AddPhotoRouterProtocol
    
    var objectsArray = [Data]()
    var selectedObject: Data?

    init(view: AddPhotoVCProtocol? = nil,
         router: AddPhotoRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension AddPhotoPresenter: AddPhotoPresenterProtocol {
    
    func getObjectsCount() -> Int {
        objectsArray.count
    }
    
    func getObject(withIndex index: Int) -> ImageObjectModel {
        ImageObjectModel(imageData: objectsArray[index])
    }

    func didSelectObject(withIndex index: Int) {
        let object = objectsArray[index]
        view?.setSelectedObject(model: ImageObjectModel(imageData: object))
        selectedObject = object
    }
    
    func onNextButtonTap() {
        guard let selectedObject = selectedObject else { return }
        router.onNextButtonTap(imageObject: selectedObject)
    }

    func openImagePicker(viewController: AddPhotoViewController) {
        router.openImagePicker(viewController: viewController)
    }
    
    func fetchAssestFromLibrary() {
        let objects = PHAsset.fetchAssets(with: .image, options: nil)
        print(objects.count)
        for index in 0..<objects.count {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            option.isSynchronous = true
            let image = objects.object(at: index)
            manager.requestImageDataAndOrientation(for: image,
                                                   options: option) { data, _, _, _ in
                guard let data = data else { return }
                self.objectsArray.append(data)
                DispatchQueue.main.async {
                    let firstImage = self.objectsArray[0]
                    self.view?.setupImageView(image: firstImage)
                    self.selectedObject = firstImage
                }
            }
        }
    }
    
    func selectedObject(object: Data) {
        selectedObject = object
    }
}
