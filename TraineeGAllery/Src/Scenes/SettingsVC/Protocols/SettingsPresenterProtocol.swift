//
//  PresenterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 28.06.23.
//

import Foundation

protocol SettingsPresenterProtocol {
    
    /// Закрытие экрана Settings
    /// - Parameter viewController: viewController, который надо закрыть
    func popViewController(viewController: SettingsViewController)
    
    /// ViewController готов к отображению
    func viewIsReady()
    
    /// Сохранение данных, которые изменил пользователь
    func saveUsersChanges()
    
    /// Метод, отправляющий запрос на удаление пользователя
    func deleteUser()
    
    /// Метод, позволяющий выйти пользователю из своего профиля
    func signOut()
    
    /// Метод, вызывающий alertController при нажатии на кнопку "Cancel"
    func setCancelAlertController()
    
    /// Метод, вызывающий alertController при нажатии на кнопку "Delete"
    func setDeleteAlertController()
    func changePassword(oldPassword: String,
                        newPassword: String)
}
