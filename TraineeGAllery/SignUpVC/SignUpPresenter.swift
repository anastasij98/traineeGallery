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
    
    ///  Запрос на регистрацию нового пользователя
    /// - Parameters:
    ///   - email: e-mail пользователя
    ///   - phone: номер телефона пользователя
    ///   - fullName: полное имя пользователя
    ///   - password: пароль пользователя
    ///   - username: имя пользователя
    ///   - birthday: дата рождения пользователя
    ///   - roles: ?
    func registerNewUser(email: String,
                         phone: String,
                         fullName: String,
                         password: String,
                         username: String,
                         birthday: String,
                         roles: [String])
    
    /// Обращение к роутеру для закрытия экрана SignUp
    /// - Parameter viewController: экран SignUp
    func popViewController(viewController: SignUpViewController)
}

class SignUpPresenter {
    
    weak var view: SignUpViewProtocol?
    var router: SignUpRouterProtocol
    var network: NetworkServiceProtocol
    var userDefaultsService: UserDefaultsServiceProtocol

    var disposeBag = DisposeBag()
    var userDisposeBag = DisposeBag()
    
    init(view: SignUpViewProtocol? = nil,
         router: SignUpRouterProtocol,
         network: NetworkServiceProtocol,
         userDefaultsService: UserDefaultsServiceProtocol) {
        self.view = view
        self.router = router
        self.network = network
        self.userDefaultsService = userDefaultsService
    }
    
   private func authorizationRequest(userName: String, password: String) {
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
    
   private func getCurrent() {
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
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: userDisposeBag)
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
                             phone: "\(Int.random(in: 2000..<9999))",
                             fullName: fullName,
                             username: username,
                             birthday: formattedBirthday,
                             roles:  [""])
        .observe(on: MainScheduler.instance)
        .debug()
        .subscribe (onSuccess: { [weak self] data in
            self?.authorizationRequest(userName: username, password: password)
            guard let usersId = data.id else { return }
            self?.userDefaultsService.saveUsersId(id: usersId)
        }, onFailure: { error in
            print(error)
        })
        .disposed(by: disposeBag)
    }
    
    func popViewController(viewController: SignUpViewController) {
        router.popViewController(viewController: viewController)
    }
}
