//
//  AlertMessageProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 28.06.23.
//

import Foundation
import UIKit

protocol AlertMessageProtocol {
    
    /// Метод вызывает аlertController с одной дефолтной кнопкой "Cancel"
    /// - Parameters:
    ///   - title: заголовок аlertController'a
    ///   - message: текст аlertController'a
    func setAlertController(title: String, message: String)
    
    /// Метод вызывает аlertController с одной дефолтной кнопкой "Cancel" и одной кастомной кнопкой
    /// - Parameters:
    ///   - title: заголовок аlertController'a
    ///   - message: текст аlertController'a
    ///   - leftButtonTitle: заголовок кнопки
    ///   - leftButtonAction: действие при нажатии на кнопку
    func alertControllerWithLeftButton(title: String, message: String, leftButtonTitle: String, leftButtonAction: @escaping (UIAlertAction) -> Void)
    
    /// Показ снэкБара(уведомляющий об успешной загрузке фотографии
    func showSnackBar()
    
    /// Показ progress HeadUpDisplay'а
    func showProgressHUD()
    
    /// Показ success HeadUpDisplay'а
    /// - Parameter completion: действие, которое будет выполненна после показа HeadUpDisplay'а
    func showSuccessHUD(completion: @escaping (Bool) -> Void)
}
