//
//  NetworkService.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 07.04.23.
//

import Foundation
import RxSwift
import Alamofire

protocol NetworkServiceProtocol {
    
    /// Загрузка картинок(Response Мodel)
    /// - Parameters:
    ///   - limit: количество элементов вна запрашиваемой странице
    ///   - pageToLoad: запрашиваемая страница
    ///   - mode: выбранный режим (New/Popular)
    ///   - searchText: введённый текст в поле SearchBar'a
    /// - Returns: возвращает Single, содержащий один объект типа ResponseModel
    func getImages(limit: Int,
                   pageToLoad: Int,
                   mode: SegmentMode?,
                   searchText: String?) -> Single<ResponseModel>
    
    /// Загрузка картинки на детальный экран
    /// - Parameters:
    ///   - name: имя картинки, взятое из модельки
    /// - Returns: возвращает Single, содержащий один объект типа Data
    func getImageFile(name: String) -> Single<Data>
    
    /// Запрос на авторизацию пользователя
    func authorizationRequest(userName: String, password: String) -> Single<AuthorizationModel>
    
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
    func registerUser(email: String,
                      password: String,
                      phone: String,
                      fullName: String,
                      username: String,
                      birthday: String,
                      roles: [String]) -> Single<ResponseRegisterModel>
    
    /// Запрос на удаление текущего пользователя
    /// - Parameter id: id пользователя
    /// - Returns: возвращает Single, содержащий один объект типа Data
    func deleteUser(id: Int) -> Single<Data>
}

