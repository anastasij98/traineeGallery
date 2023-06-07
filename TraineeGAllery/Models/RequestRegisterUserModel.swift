//
//  RegisterUserModel.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 05.06.23.
//

import Foundation
import RxNetworkApiClient

struct RequestRegisterModel: Codable, JsonBodyConvertible {

    var email: String?
    var phone: String?
    var fullName: String?
    var password: String?
    var username: String?
    var birthday: String?
    var roles: [String]?
}
