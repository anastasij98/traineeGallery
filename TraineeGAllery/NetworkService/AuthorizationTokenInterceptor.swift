//
//  AuthorizationTokenInterceptor.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 30.05.23.
//

import Foundation
import RxNetworkApiClient
import RxSwift


class AuthInterceptor: Interceptor {

    var userDef: UserDefaultsServiceProtocol?

    init(_ userDef: UserDefaultsServiceProtocol) {
        self.userDef = userDef
    }
    
    func prepare<T: Codable>(request: ApiRequest<T>) {
        guard let path = request.path,
              !path.contains("oauth/v2/token") && path != ("api/users")
        else { return }
        guard let accessToken = userDef?.getAccessToken() else { return }
                let hasAuthHeader = request.headers?.contains(where: { header in
                    header.key == "Authorization"
                })

                if hasAuthHeader != true {
                    if request.headers == nil {
                        request.headers = []
                    }
                    request.headers!.append(Header("Authorization", "Bearer \(accessToken)"))
                }
    }

    func handle<T: Codable>(request: ApiRequest<T>, response: NetworkResponse) {

    }
    
    private func getStatusEmoji(_ code: Int) -> String {
        if (200...300).contains(code) {
            return "👌"
        } else if (400...500).contains(code) {
            return "🤔"
        } else if (500...600).contains(code) {
            return "💥"
        }
        return ""
    }
}

extension ApiClientImp {
    
    public static func authInstance(host: String) -> ApiClientImp {
        ApiEndpoint.baseEndpoint = ApiEndpoint(host)
        let apiClient = ApiClientImp(urlSession: URLSession.shared)
        apiClient.interceptors.append(AuthInterceptor(UserDefaultsService()))
        apiClient.responseHandlersQueue.append(JsonResponseHandler())
        return apiClient
    }
}
