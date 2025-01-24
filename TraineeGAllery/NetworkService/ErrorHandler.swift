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
    var disposeBag = DisposeBag()
    private var userUseCase: UserUseCaseImp
    private var api: ApiClient
    
    init(userUseCase: UserUseCaseImp,
         api: ApiClient) {
        self.userUseCase = userUseCase
        self.api = api
    }
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
                    self.userUseCase.requestWithRefreshToken(refreshToken: refreshToken)
                        .subscribe(onSuccess: { model in
                            guard let accessToken = model.access_token,
                                  let refreshToken = model.refresh_token else {
                                return }
                            self.userDef.saveTokens(accessToken: accessToken, refreshToken: refreshToken)
                            print(model)
                            self.api.execute(request: request)
                            
                        }, onFailure: { error in
                            print(error)
                        })
                        .disposed(by: disposeBag)
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
