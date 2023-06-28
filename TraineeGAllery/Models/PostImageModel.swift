//
//  PostImageModel.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 15.06.23.
//

import Foundation
import RxNetworkApiClient

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
