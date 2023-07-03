//
//  AddPhotoRouterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol AddPhotoRouterProtocol {
    
    /// Обращение к конфигуратору для открытия AddDataViewController'a
    /// - Parameter imageObject: передаваемый объект в виде Data
    func onNextButtonTap(imageObject: Data)
    
    /// Oткрытие ImagePicker'a
    /// - Parameter viewController: передаваемый viewController
    func openImagePicker(viewController: AddPhotoViewController)
}
