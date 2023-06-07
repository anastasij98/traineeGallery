//
//  SignInPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.04.23.
//

import Foundation
import RxSwift

protocol SignInPresenterProtocol {
    
    /// Обращение к роутеру для открытия экрана с TabBarController'ом
    func openTabBar()
    
    /// Обращение к networkServic'y для отправки запроса на авторизацию
    func signInButtonTap(userName: String, password: String)
}

class SignInPresenter {
    
    weak var view: SignInViewProtocol?
    var router: SignInRouterProtocol
    var network: NetworkServiceProtocol
    var userDefaultsService: UserDefaultsServiceProtocol
    
    var disposeBag = DisposeBag()
    var userDisposeBag = DisposeBag()
    
    
    init(view: SignInViewProtocol? = nil,
         router: SignInRouterProtocol,
         network: NetworkServiceProtocol,
         userDefaultsService: UserDefaultsServiceProtocol) {
        self.view = view
        self.router = router
        self.network = network
        self.userDefaultsService = userDefaultsService
    }
}

extension SignInPresenter: SignInPresenterProtocol {
    
    func openTabBar() {
        router.openTabBarController()
    }
    
    func signInButtonTap(userName: String, password: String) {
        network.authorizationRequest(userName: userName, password: password)
            .observe(on: MainScheduler.instance)
            .debug()
            .subscribe (onSuccess: { [weak self] data in
                guard let accessToken = data.access_token else { return }
                self?.userDefaultsService.saveAccessToken(token: accessToken)
                self?.getCurrent()
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func getCurrent() {
        network.getCurrentUser()
            .observe(on: MainScheduler.instance)
            .debug()
            .subscribe (onSuccess: { [weak self] data in
                guard let fullName = data.fullName,
                      let birthday = data.birthday,
                      let email = data.email,
                      let usersId = data.id else { return }
                let formattedDate =  FormattedDateString.getFormattedDateString(string: birthday)
                self?.userDefaultsService.saveUsersInfo(name: fullName,
                                                        birthday: formattedDate,
                                                        email: email)
                self?.userDefaultsService.saveUsersId(id: usersId)
                self?.router.openTabBarController()
                
                print(usersId)
                print(data)
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: userDisposeBag)
    }
}
