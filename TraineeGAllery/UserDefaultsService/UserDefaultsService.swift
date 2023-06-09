//
//  UserDefaultsService.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 31.05.23.
//

import Foundation

class UserDefaultsService {
    
    var accessTokenKey = "accessToken"
    var nameKey = "name"
    var birthdayKey = "birthday"
    var emailKey = "email"
    var usersId = "usersId"
}

extension UserDefaultsService: UserDefaultsServiceProtocol {
    
    func saveAccessToken(token: String) {
        UserDefaults.standard.set(token, forKey: accessTokenKey)
    }
    
    func getAccessToken() -> String {
        guard let token = UserDefaults.standard.string(forKey: accessTokenKey) else {
            return "" }
        return token
    }
    
    func saveUsersInfo(name: String, birthday: String, email: String) {
        UserDefaults.standard.set(name, forKey: nameKey)
        UserDefaults.standard.set(birthday, forKey: birthdayKey)
        UserDefaults.standard.set(email, forKey: emailKey)
    }
    
    func getUsersInfo() -> (name: String, birthday: String, email: String) {
        guard let name = UserDefaults.standard.string(forKey: nameKey),
              let birthday = UserDefaults.standard.string(forKey: birthdayKey),
              let email = UserDefaults.standard.string(forKey: emailKey) else {
            return ("Visitor","01.01.1901","email@adress.com") }
        
        return (name, birthday, email)
    }
    
    func saveUsersId(id:Int) {
        UserDefaults.standard.set(id, forKey: usersId)
    }
    
    func getUsersId() -> Int {
        let id = UserDefaults.standard.integer(forKey: usersId)
        return id
    }
    
    func removeTokensAndUsersInfo() {
        var usersInfo = [accessTokenKey, nameKey, birthdayKey, usersId, emailKey]
        usersInfo.forEach { key in
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
}
