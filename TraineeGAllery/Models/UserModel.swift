//
//  UserModel.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 31.05.23.
//

import Foundation

struct CurrentUserModel: Codable {
    
    var id: Int?
    var email: String?
    var enabled: Bool?
    var phone: String?
    var fullName: String?
    var userName: String?
    var birthday: String?
    var roles: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, email, enabled, phone, fullName, birthday, roles
        case userName = "username"
    }
}
