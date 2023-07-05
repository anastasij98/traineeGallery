//
//  DI.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 29.06.23.
//

import Foundation
import DITranquillity
import RxNetworkApiClient

class DI {
    
    private static let shared = DI()
    fileprivate(set) static var container = DIContainer()
    fileprivate(set) static var backgroundContainer = DIContainer()

    private init() {
        
    }
    
    static func initBackgroundDependencies() { }
    
    // swiftlint:disable function_body_length
    static func initDependencies(_ appDelegate: AppDelegate) {
        
        DI.container = DIContainer(parent: backgroundContainer)
        ApiEndpoint.baseEndpoint = ApiEndpoint.webAntDevApi

        self.container.register(UserDefaultsService.init)
            .as(UserDefaultsServiceProtocol.self)
            .lifetime(.single)
        
        self.container.register { () -> ApiClientImp in
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 60 * 20
            config.timeoutIntervalForResource = 60 * 20
            config.waitsForConnectivity = true
            config.shouldUseExtendedBackgroundIdleMode = true
            config.urlCache?.removeAllCachedResponses()
            let client = ApiClientImp(urlSessionConfiguration: config, completionHandlerQueue: .main)
            client.responseHandlersQueue.append(ErrorResponseHandler())
            client.responseHandlersQueue.append(JsonResponseHandler())

            client.interceptors.append(ModifiedInterceptor())
            client.interceptors.append(AuthInterceptor(DI.resolve()))
            return client
        }
        .as(ApiClient.self)
        .lifetime(.single)
        
        //MARK: - Gateways
        self.container.register(ApiUserGateway.init)
            .as(UserGateway.self)
            .lifetime(.single)
        
        self.container.register(ApiFileGateway.init)
            .as(FileGateway.self)
            .lifetime(.single)
        
        //MARK: - UseCase
        self.container.register(UserUseCaseImp.init)
            .as(UserUseCase.self)
        
        self.container.register(FileUseCaseImp.init)
            .as(FileUseCase.self)
    }
    // swiftlint:enable function_body_length

    static func resolve<T>() -> T {
        self.container.resolve()
    }
    
    static func resolveBackground<T>() -> T {
        self.backgroundContainer.resolve()
    }
}
