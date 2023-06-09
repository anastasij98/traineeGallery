//
//  ProfilePresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 08.05.23.
//

import Foundation
import RxSwift

protocol ProfilePresenterProtocol {
    
    /// Обращение к роутеру для открытия экрана настроек(Settings)
    func openSettings()
    
    /// Открытие TabBarController'a
    /// - Parameter index: индекс выбранного экрана 
    func openTabBarViewController(index: Int)
    
    /// View готово к отображению
    func viewIsReady()
}

class ProfilePresenter {
    
    weak var view: ProfileVCProtocol?
    var router: ProfileRouterProtocol
    var network:NetworkServiceProtocol
    var userDef: UserDefaultsServiceProtocol
    
    init(view: ProfileVCProtocol? = nil,
         router: ProfileRouterProtocol,
         network: NetworkServiceProtocol,
         userDef: UserDefaultsServiceProtocol) {
        self.view = view
        self.router = router
        self.network = network
        self.userDef = userDef
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    
    func openSettings() {
        router.openSettings()
    }
    
    func openTabBarViewController(index: Int) {
        router.openTabBarViewController(index: index)
    }
    
    func viewIsReady() {
        view?.setupView(userName: userDef.getUsersInfo().name,
                        birthday: userDef.getUsersInfo().birthday)
    }
}
