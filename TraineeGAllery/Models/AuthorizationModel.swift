//
//  AuthorizationModel.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 30.05.23.
//

import Foundation

struct AuthorizationModel: Codable {

    var access_token: String?
    var expires_in: Int?
    var token_type: String?
    var scope: String?
    var refresh_token: String?
}
