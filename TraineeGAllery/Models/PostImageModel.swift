//
//  PostImageModel.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 15.06.23.
//

import Foundation

struct PostImageModel: Codable {
    
    var name: String?
    var dateCreate: Date?
    var description: String?
    var new: Bool?
    var popular: Bool?
    var image: Data?
}
