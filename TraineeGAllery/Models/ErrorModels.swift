//
//  ErrorModels.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.06.23.
//

import Foundation

struct ErrorModel: Codable {
    
    var detail: String?
}

struct ErrorModelTokenExpired: Codable {
    
    var error: String?
    var error_description: String?
}
