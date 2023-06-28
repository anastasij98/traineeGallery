//
//  RegisterUserModel.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 06.06.23.
//

import Foundation

struct ResponseRegisterModel: Codable {
    
    var phone: String?
    var fullName: String?
    var oldPassword: String?
    var newPassword: String?
    var birthday: String?
    var photos: [String]?
    var code: String?
    var user: Bool?
    var rolesRaw: [String]?
    var username: String?
    var roles: [String]?
    var id: Int?
    var usernameCanonical: String?
    var salt: String?
    var email: String?
    var emailCanonical: String?
    var password: String?
    var plainPassword: String?
    var lastLogin: String?
    var confirmationToken: String?
    var accountNonExpired: Bool?
    var accountNonLocked: Bool?
    var credentialsNonExpired: Bool?
    var enabled: Bool?
    var superAdmin: Bool?
    var passwordRequestedAt: String?
    var groups: [String]?
    var group: [String]?
}
