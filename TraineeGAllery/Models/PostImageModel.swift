//
//  PostImageModel.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 15.06.23.
//

import Foundation
import RxNetworkApiClient

struct FileEntity: JsonBodyConvertible {

    var file: String?
    var name: String?
}

//struct FileEntity: JsonBodyConvertible {
//    
//    var file: Data?
//    var name: String?
//}
