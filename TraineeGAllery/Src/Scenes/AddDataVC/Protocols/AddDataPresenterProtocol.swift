//
//  AddDataPresenterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol AddDataPresenterProtocol {
    
    /// Закрывает экран AddDataViewController
    func popViewController(viewController: AddDataViewController)
    
    /// Получение текущей даты в формате "yyyy-MM-dd’T’HH:mm:ssZ"
    func getCurrentDate() -> String
    
    /// POST запрос на загрузку картинки
    /// - Parameters:
    ///   - name: имя
    ///   - file: картинка в виде Data
    ///   - dateCreate: дата создания
    ///   - description: описание
    ///   - viewController: вьюКонтроллер, который будет закрыт в случае успешного выполнения запроса (в данном случае AddDataViewController)
    func postMediaObject(name: String,
                     file: Data,
                     dateCreate: String,
                     description: String,
                     new: Bool,
                     popular: Bool,
                     viewController: AddDataViewController)
}
