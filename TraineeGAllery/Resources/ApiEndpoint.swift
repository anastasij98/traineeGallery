//
//  ApiEndpoint.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 05.07.23.
//

import Foundation
import RxNetworkApiClient

extension ApiEndpoint {

    private(set) static var webAntDevApi = ApiEndpoint(URLConfiguration.url)
    
    static func updateEndpoint() {
        ApiEndpoint.webAntDevApi = ApiEndpoint(URLConfiguration.url)
    }
}
