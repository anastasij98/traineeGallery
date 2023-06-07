//
//  SignInPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation
import RxSwift

protocol SignUpPresenterProtocol {
    
    /// Обращение к роутеру для открытия экрана SigIn
    func onSignInButtonTap()
    func registerNewUser(email: String,
                         phone: String,
                         fullName: String,
                         password: String,
                         username: String,
                         birthday: String,
                         roles: [String])
}

class SignUpPresenter {
    
    weak var view: SignUpViewProtocol?
    var router: SignUpRouterProtocol
    var network: NetworkServiceProtocol
    var userDefaultsService: UserDefaultsServiceProtocol

    var disposeBag = DisposeBag()
    
    init(view: SignUpViewProtocol? = nil,
         router: SignUpRouterProtocol,
         network: NetworkServiceProtocol,
         userDefaultsService: UserDefaultsServiceProtocol) {
        self.view = view
        self.router = router
        self.network = network
        self.userDefaultsService = userDefaultsService
    }
}

extension SignUpPresenter: SignUpPresenterProtocol {
    
    func onSignInButtonTap() {
        router.openSignInViewController()
    }
    
    func registerNewUser(email: String,
                          phone: String,
                          fullName: String,
                          password: String,
                          username: String,
                          birthday: String,
                          roles: [String]) {

        
        let formattedBirthday = FormattedDateString.setFormattedDateString(string: birthday)
        network.registerUser(email: email,
                             password: password,
                             phone: "89890",
                             fullName: fullName,
                             username: username,
                             birthday: formattedBirthday,
                             roles:  [""])
        .observe(on: MainScheduler.instance)
        .debug()
        .subscribe (onSuccess: { [weak self] data in
//            self?.authorizationRequest(userName: username, password: password)
            print(data)
            guard let usersId = data.id else { return }
            self?.userDefaultsService.saveUsersId(id: usersId)
            self?.openTabBar()
            print(usersId)
        }, onFailure: { error in
            print(error)
        })

        .disposed(by: disposeBag)
    }
    
    func authorizationRequest(userName: String, password: String) {
        network.authorizationRequest(userName: userName, password: password)
            .observe(on: MainScheduler.instance)
            .debug()
            .subscribe (onSuccess: { [weak self] data in
                guard let accessToken = data.access_token else { return }
                print("@@@@@@@@")
                self?.openTabBar()
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func openTabBar() {
        router.openTabBarController()
    }
}


//    .observe(on: MainScheduler.instance)
//    .debug()
//        .flatMap({ (userModel) -> Single<AuthorizationModel> in
//            return self.network.authorizationRequest(userName: <#T##String#>,
//                                                password: <#T##String#>)
//        })
//        .subscribe( onSuccess: { authResponse
//        обрабатываешь результат authorize
//        })
//    .subscribe (onSuccess: { [weak self] data in
//        self?.authorizationRequest(userName: username, password: password)
//        print(data)
//    }, onFailure: { error in
//        print(error)
//    })
