//
//  DetailedVCProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol DetailedViewControllerProtocol: AnyObject {
    
    /// Установка информации о выбранной картинке в галерее
    /// - Parameters:
    ///   - name: имя картинки
    ///   - user: имя пользователя
    ///   - description: описание картинки
    ///   - date: дата добавления картинки
    func setupView(name: String,
                   user: String,
                   description: String,
                   date: String)
    
    /// Установка изображения выбранной картинке в галерее
    /// - Parameter data: картинка в виде Data
    func setImage(data: Data)
}
