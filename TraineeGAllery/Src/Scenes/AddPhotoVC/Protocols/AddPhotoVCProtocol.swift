//
//  AddPhotoVCProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol AddPhotoVCProtocol: AnyObject {
    
    /// Установка выбранного объекта в imageView.image AddPhotoViewController'a
    /// - Parameter model: модель объекта типа ImageObjectModel
    func setSelectedObject(model: ImageObjectModel)
    
    /// Установка картинки в imageView
    /// - Parameter image: картинка в формате Data
    func setupImageView(image: Data)
}
