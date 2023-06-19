//
//  SignInPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation
import RxSwift
import RxNetworkApiClient

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
                             phone: "\(Int.random(in: 1000..<9999))",
                             fullName: fullName,
                             username: username,
                             birthday: formattedBirthday,
                             roles:  [""])
        .observe(on: MainScheduler.instance)
        .debug()
        .flatMap({ [weak self] (userModel) -> Single<AuthorizationModel> in
            guard let self = self,
                  let usersId = userModel.id else {
                return .error(NSError(domain: "", code: 0, userInfo: nil))
            }
            self.userDefaultsService.saveUsersId(id: usersId)
            
            return self.network.authorizationRequest(userName: username,
                                                     password: password)
        })
        .flatMap({ [weak self] (authModel) -> Single<CurrentUserModel> in
            guard let self = self,
                  let accessToken = authModel.access_token else {
                return .error(NSError(domain: "", code: 0, userInfo: nil)) }
            self.userDefaultsService.saveAccessToken(token: accessToken)
            
            return self.network.getCurrentUser()
        })
        .subscribe (onSuccess: { [weak self] (currentUserModel) in
            guard let self = self,
                  let fullName = currentUserModel.fullName,
                  let birthday = currentUserModel.birthday,
                  let email = currentUserModel.email,
                  let usersId = currentUserModel.id else { return }
            let formattedDate =  FormattedDateString.getFormattedDateString(string: birthday)
            self.userDefaultsService.saveUsersInfo(name: fullName,
                                                   birthday: formattedDate,
                                                   email: email)
            self.userDefaultsService.saveUsersId(id: usersId)
            DispatchQueue.main.async {
                self.router.openTabBarController()
            }
            print(currentUserModel)
        }, onFailure: { error in
            print(error)
            
            self.view?.setAlertController(title: "Error", message: "\(error.localizedDescription)")
        })
        .disposed(by: disposeBag)
    }
    
    func popViewController(viewController: SignUpViewController) {
        router.popViewController(viewController: viewController)
    }
}
