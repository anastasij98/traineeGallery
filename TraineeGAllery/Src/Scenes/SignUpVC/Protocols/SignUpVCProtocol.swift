//
//  SignUpVCProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol SignUpViewProtocol: AnyObject, AlertMessageProtocol {
    
    /// Показ UILabel'a с текстом ошибки
    func showEmailError()
    
    /// Показ UILabel'a с текстом ошибки
    func showUserNameError()
    
    /// Показ UILabel'a с текстом ошибки
    func showBirthdayError()
    
    /// Показ UILabel'a с текстом ошибки
    func passwordError()
    
    /// Функция, сравнивающая пароли на равенство
    func confirmPasswordError(isPasswordValid: Bool)
    
    /// Показ AlertControl'a, который уведомляет о некорректном вводе данных
    func showAlertControl()
}
