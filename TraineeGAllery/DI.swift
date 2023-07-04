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
        
        //MARK: - Gateways
        self.container.register(ApiUserGateway.init)
            .as(UserGateway.self)
            .lifetime(.single)
        
        //MARK: - UseCase
        self.container.register(UserUseCaseImp.init)
            .as(UserUseCase.self)
    }
    // swiftlint:enable function_body_length

    static func resolve<T>() -> T {
        self.container.resolve()
    }
    
    static func resolveBackground<T>() -> T {
        self.backgroundContainer.resolve()
    }
}
