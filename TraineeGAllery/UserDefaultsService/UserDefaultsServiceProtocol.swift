//
//  UserDefaultsServiceProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 09.06.23.
//

import Foundation

protocol UserDefaultsServiceProtocol {
    
    /// Метод, сохраняющий accessToken и refreshToken в userDefaults
    /// - Parameters:
    ///   - token: передаваемый token для кодирования и сохранения в userDefults
    func saveTokens(accessToken: String, refreshToken: String)
    
    /// Метод, возвращающий accessToken из userDefaults
    func getAccessToken() -> String
    
    /// Метод, возвращающий refreshToken из userDefaults
    func getRefreshToken() -> String
    
    /// Метод, сохраняющий данные пользователя(имя, день рождения, e-mail адрес) в userDefaults
    /// - Parameters:
    ///   - name: имя пользователя
    ///   - birthday: день рождения пользователя
    ///   - email:  e-mail адрес пользователя
    func saveUsersInfo(name: String, birthday: String, email: String)
    
    /// Метод, возвращающий данные пользователя(имя, день рождения, e-mail адрес) из userDefaults
    /// - Returns: возвращаемы объект является tupl'ом, который  содержит имя, дату рождения и e-mail адрес пользовтаеля
    func getUsersInfo() -> (name: String, birthday: String, email: String)
    
    /// Метод, сохраняющий id пользователя в userDefaults
    /// - Parameter id: id пользователя
    func saveUsersId(id: Int)
    
    /// Метод, возвращающий id пользователя из userDefaults
    /// - Returns: id пользователя
    func getUsersId() -> Int
    
    /// Метод, удаляющий accesToken и данные пользователя из userDefaults
    func removeTokensAndUsersInfo()
}
