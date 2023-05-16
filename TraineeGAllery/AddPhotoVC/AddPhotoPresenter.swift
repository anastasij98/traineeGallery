//
//  AddPhotoPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import Photos

protocol AddPhotoPresenterProtocol {
    
    func onNextButtonTap()
    func openImagePicker(view: AddPhotoViewController)
    
    func fetchAssestFromLibrary()
    
    func getObjectsCount() -> Int
    func getObject(withIndex index: Int) -> ImageObjectModel
    func didSelectObject(withIndex index: Int)
    func selectedObject(object: Data)
}

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

    func openImagePicker(view: AddPhotoViewController) {
        router.openImagePicker(view: view)
    }
    
    func fetchAssestFromLibrary() {
        
        let objects = PHAsset.fetchAssets(with: .image, options: nil)
        print(objects.count)
        for index in 0..<objects.count {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var selfData = Data()
            option.isSynchronous = true
            let image = objects.object(at: index)
            manager.requestImageDataAndOrientation(for: image,
                                                   options: option) { data, _, _, _ in
                selfData = data!
                print(selfData)
                
                self.objectsArray.append(data!)
            }
        }
    }
    
    func selectedObject(object: Data) {
        selectedObject = object
    }

}
