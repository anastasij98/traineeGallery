//
//  JSONModel.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.03.23.
//

import Foundation

struct ResponseModel: Codable {
    
    var data: [ItemModel]
    var itemsPerPage: Int?
    var countOfPages: Int?
    var totalItems: Int?
}

struct ItemModel: Codable {
    
    var id: Int?
    var name: String?
    var description: String?
    var date: String?
    var new: Bool?
    var popular: Bool?
    var image: ImageModel?
    var user: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, new, popular, image, description, user
        case date = "dateCreate"
    }
}

struct ImageModel: Codable {
    
    var id: Int?
    var name: String?
}
