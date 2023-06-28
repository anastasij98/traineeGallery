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
    let userDef = UserDefaultsService()
    var networkService: NetworkService?
    var disposeBag = DisposeBag()
    
    // swiftlint:disable function_body_length
    public func handle<T: Codable>(observer: @escaping SingleObserver<T>,
                                   request: ApiRequest<T>,
                                   response: NetworkResponse) -> Bool {
        guard let urlResponse = response.urlResponse,
              let nsHttpUrlResponse = urlResponse as? HTTPURLResponse else {
            return false
        }

        if nsHttpUrlResponse.statusCode == 401 {
            print("401 401 401 401 401 401 401")
            if let data = response.data {
                if let customError = try? jsonDecoder.decode(ErrorModelTokenExpired.self, from: data) {
                    let refreshToken = userDef.getRefreshToken()
//                    networkService?.requestWithRefreshToken(refreshToken: refreshToken)
//                        .observe(on: MainScheduler.instance)
//                        .do(onSuccess: { model in
//                            guard let accessToken = model.access_token,
//                                  let refreshToken = model.refresh_token else {
//                                return }
//                            self.userDef.saveTokens(accessToken: accessToken, refreshToken: refreshToken)
//                            print(model)
//                        })
//                        .subscribe()
//                        .disposed(by: disposeBag)
                    print(customError.error)
                    print(customError.error_description)
                }
            }
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
