//
//  UserGateway.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 29.06.23.
//

import Foundation
import RxSwift

protocol UserGateway {

    /// Запрос для получения информации о поьзователе
    /// - Returns: возвращает информацию о пользователе в виде UserModel
    func getCurrentUser() -> Single<CurrentUserModel>
    
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
    func registerUser(entity: RequestRegisterModel) -> Single<ResponseRegisterModel>
    
    /// Запрос на удаление текущего пользователя
    /// - Parameter id: id пользователя
    /// - Returns: возвращает Single, содержащий один объект типа Data
    func deleteUser(id: Int) -> Single<Data>
    
    /// Запрос на авторизацию пользователя
    func authorizationRequest(userName: String, password: String) -> Single<AuthorizationModel>
}
