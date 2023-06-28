//
//  SignInPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.04.23.
//

import Foundation
import RxSwift

class SignInPresenter {
    
    weak var view: SignInViewProtocol?
    var router: SignInRouterProtocol
    var network: NetworkServiceProtocol
    var userDefaultsService: UserDefaultsServiceProtocol
    
    var disposeBag = DisposeBag()    
    
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
    
    func signInButtonTap(userName: String,
                         password: String) {
        network.authorizationRequest(userName: userName, password: password)
            .observe(on: MainScheduler.instance)
            .debug()
            .flatMap({ [weak self] (authModel) -> Single<CurrentUserModel> in
                guard let self = self,
                      let accessToken = authModel.access_token,
                      let refreshToken = authModel.refresh_token else  {
                    return .error(NSError(domain: "", code: 0, userInfo: nil)) }
                self.userDefaultsService.saveTokens(accessToken: accessToken, refreshToken: refreshToken)
                
                return self.network.getCurrentUser()
            })
            .subscribe (onSuccess: { [weak self] currentUserModel in
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
                    self.openTabBar()
                }
                print(currentUserModel)
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func popViewController(viewController: SignInViewController) {
        router.popViewController(viewController: viewController)
    }
}
