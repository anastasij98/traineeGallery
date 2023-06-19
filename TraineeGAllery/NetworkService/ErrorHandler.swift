//
//  ErrorHandler.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 19.06.23.
//

import Foundation
import RxSwift
import RxNetworkApiClient

open class ErrorResponseHandler: ResponseHandler {
    
    private let jsonDecoder = JSONDecoder()

    // swiftlint:disable function_body_length
    public func handle<T: Codable>(observer: @escaping SingleObserver<T>,
                                   request: ApiRequest<T>,
                                   response: NetworkResponse) -> Bool {
        guard let urlResponse = response.urlResponse,
            let nsHttpUrlResponse = urlResponse as? HTTPURLResponse else {
                return false
        }

        if (300..<600).contains(nsHttpUrlResponse.statusCode) {
            let errorEntity = ResponseErrorEntity(response.urlResponse)

            if let data = response.data {
                if let customError = try? jsonDecoder.decode(ErrorModel.self, from: data),
                   let error = customError.detail {
                    errorEntity.errors.append(error)
                    print(error)
                }
            }

            observer(.failure(errorEntity))
            return true
        }
        return false
    }
    // swiftlint:enable function_body_length
}
