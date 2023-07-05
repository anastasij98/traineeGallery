//
//  UserUseCase.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 02.07.23.
//

import Foundation
import RxSwift

protocol UserUseCase {
    
    /// Запрос для получения информации о поьзователе
    /// - Returns: возвращает информацию о пользователе в виде UserModel
    func getCurrentUserinfo() -> Completable
    
    /// Запрос регистрации нового пользователя
    /// - Parameters:
    ///   - email: email пользователя
    ///   - phone: номер телефона
    ///   - fullName: полное имя пользователя
    ///   - password: пароль
    ///   - username: имя пользователя
    ///   - birthday: дата рождения
    ///   - roles: ?
    /// - Returns: при успешном запросе, возвращает информацию о пользователе в виде UserModel
    func registerUser(entity: RequestRegisterModel) -> Completable
    
    /// Запрос на удаление текущего пользователя
    /// - Parameter id: id пользователя
    /// - Returns: возвращает Single, содержащий один объект типа Data
    func deleteUser(id: Int) -> Completable
    
    /// Запрос на авторизацию пользователя
    func authorization(userName: String, password: String) -> Completable
}
