//
//  SettingsVCProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 28.06.23.
//

import Foundation
import UIKit

protocol SettingsVCProtocol: AnyObject, AlertMessageProtocol {
    
    /// Установка данных пользователя в соответсвующие поля
    /// - Parameters:
    ///   - userName: имя пользователя
    ///   - birthday: дата рождения пользователя
    ///   - email: email пользователя
    func setupView(userName: String,
                   birthday: String,
                   email: String)
    
    /// Данные, которые нужно сохрнаить в usedrDefaults и передать на экран ProfileVC
    /// - Parameter completion: completion handler
    func textForSaving(completion: (_ userName: String, _ birthday: String, _ email: String)  -> Void)
    
    ///  Метод, позволяющий удалить аккаунт пользователя
    func deleteUser(action: UIAlertAction)
    
    /// Закрывает текущий экран, возвращая пользователя на предыдущий
    func popViewController(action: UIAlertAction)
}

