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
    
    private let shared = DI()
    fileprivate(set) static var container = DIContainer()
    fileprivate(set) static var backgroundContainer = DIContainer()

    init() { }
    
    static func initBackgroundDependencies() { }
    
    static func initDependencies(_ appDelegate: AppDelegate) {
        
        DI.container = DIContainer(parent: backgroundContainer)
        
        //MARK: - Gateways
        self.container.register(ApiUserGateway.init)
            .as(UserGateway.self)
            .lifetime(.single)
        
        //MARK: - UseCase
        self.container.register(UserUseCaseImp.init)
            .as(UserUseCase.self)
            .lifetime(.single)
    }
    
    static func resolve<T>() -> T {
        self.container.resolve()
    }
    
    static func resolveBackground<T>() -> T {
        self.backgroundContainer.resolve()
    }
}
