//
//  JSONModel.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.03.23.
//

import Foundation
import RxNetworkApiClient

struct ResponseModel: Codable {
    
    var data: [ItemModel]
    var itemsPerPage: Int?
    var countOfPages: Int?
    var totalItems: Int?
}

struct ItemModel: JsonBodyConvertible {
    
    var id: Int?
    var name: String?
    var description: String?
    var date: String?
    var new: Bool?
    var popular: Bool?
    var image: ImageModel?
    var iriId: String?
    var user: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, new, popular, image, description, user
        case date = "dateCreate"
    }
}

struct ImageModel: Codable {
    
    var file: String?
    var id: Int?
    var name: String?
}

struct PostImageModel: JsonBodyConvertible {
    
    var id: Int?
    var name: String?
    var description: String?
    var date: String?
    var new: Bool?
    var popular: Bool?
    var image: String?
    var iriId: String?
    var user: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, new, popular, image, description, user
        case date = "dateCreate"
    }
}
