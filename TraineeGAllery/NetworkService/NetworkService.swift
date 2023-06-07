//
//  NetworkService.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 07.04.23.

import Foundation
import RxSwift
import RxNetworkApiClient

class NetworkService {
    
    //    private let interceptor = AuthInterceptor(UserDefaultsService())
    //    private let apiClient: ApiClient = ApiClientImp.modifiedInstance(host: "https://gallery.prod1.webant.ru/")
    //    private let apiClient: ApiClient = ApiClientImp.authInstance(host: "https://gallery.prod1.webant.ru/")
    private var apiClient: ApiClient = {
        //        ApiEndpoint.baseEndpoint = ApiEndpoint("https://gallery.prod1.webant.ru/")
        //        let apiClient = ApiClientImp(urlSession: URLSession.shared)
        let apiClient = ApiClientImp.authInstance(host: "https://gallery.prod1.webant.ru/")
        apiClient.interceptors.append(ModifiedInterceptor())
        //        apiClient.interceptors.append(AuthInterceptor(UserDefaultsService()))
        //        apiClient.responseHandlersQueue.append(JsonResponseHandler())
        return apiClient
    }()
}

extension NetworkService: NetworkServiceProtocol {
    
    func getImages(limit: Int,
                   pageToLoad: Int,
                   mode: SegmentMode?,
                   searchText: String?) -> Single<ResponseModel> {
        
        var searchedText = String()
        var switched: (String, String) = ("","")
        if let mode = mode {
            switch mode {
            case .new:
                switched = ("new", "true")
                if let searchText {
                    searchedText = searchText
                }
            case .popular:
                switched = ("popular", "true")
                if let searchText {
                    searchedText = searchText
                }
            }
        }
        let request: ApiRequest<ResponseModel> = .request(path: "api/photos/",
                                                          method: .get,
                                                          query: switched,
                                                          ("limit", "\(limit)"),
                                                          ("page", "\(pageToLoad)"),
                                                          ("name", searchedText))
        
        return apiClient.execute(request: request)
    }
    
    func getImageFile(name: String) -> Single<Data> {
        let request: ApiRequest<Data> = .request(path: "media/\(name)",
                                                 method: .get)
        
        return apiClient.execute(request: request)
    }
    
    
    func authorizationRequest(userName: String, password: String) -> Single<AuthorizationModel> {
        let clientId = "1_3fxvjh2ky7s44cskwcgo0k8cwwogkocs8k4cwcwsg0skcsw4ok"
        let clientSecret = "4tf1qez2dc4ksg8w4og4co4w40s0gokwwkwkss8gc400owkokc"
        
        let request: ApiRequest<AuthorizationModel> = .request(path: "oauth/v2/token",
                                                               method: .get,
                                                               query: ("client_id", clientId),
                                                               ("grant_type","password"),
                                                               ("username", userName),
                                                               ("password", password),
                                                               ("client_secret", clientSecret))
        
        return apiClient.execute(request: request)
    }
    
    func getCurrentUser() -> Single<CurrentUserModel> {
        let request: ApiRequest<CurrentUserModel> = .request(path: "api/users/current",
                                                             method: .get)
        
        return apiClient.execute(request: request)
    }
    
    func registerUser(email: String,
                      password: String,
                      phone: String,
                      fullName: String,
                      username: String,
                      birthday: String,
                      roles: [String]) -> Single<ResponseRegisterModel> {
        
        let body = RequestRegisterModel(email: email,
                                        phone: phone,
                                        fullName: fullName,
                                        password: password,
                                        username: username,
                                        birthday: birthday,
                                        roles: roles)
        let header: Header = Header("Content-Type", "application/json")
        let request: ApiRequest<ResponseRegisterModel> = .request(path: "api/users",
                                                                  method: .post,
                                                                  headers: [header],
                                                                  body: body)
        
        return apiClient.execute(request: request)
    }
    
    func deleteUser(id: Int) -> Single<Data> {
        let header: Header = Header("Content-Type", "application/json")
        let request: ApiRequest<Data> = .request(path: "api/users/\(id)",
                                                 method: .delete,
                                                 headers: [header])
        
        return apiClient.execute(request: request)
    }
}
