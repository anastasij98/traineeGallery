//
//  ApiBaseGateway.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 29.06.23.
//

import Foundation
import RxNetworkApiClient

class ApiBaseGateway {
    
    let apiClient: ApiClient
    
    init(_ apiClient: ApiClient) {
        self.apiClient = apiClient
    }
}
