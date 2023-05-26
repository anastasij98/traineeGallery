//
// Created by admin on 06.09.2018.
// Copyright (c) 2018 WebAnt. All rights reserved.
//

import Foundation


open class ResponseErrorEntity: LocalizedError {

    public var errors = [String]()
    public let urlResponse: URLResponse?
    public let urlRequest: URLRequest?
    public var statusCode: Int? {
        return (urlResponse as? HTTPURLResponse)?.statusCode
    }


    public init(_ urlResponse: URLResponse? = nil, _ urlRequest: URLRequest? = nil) {
        self.urlResponse = urlResponse
        self.urlRequest = urlRequest
    }

    open var errorDescription: String? {
        return errors.joined()
    }
}
