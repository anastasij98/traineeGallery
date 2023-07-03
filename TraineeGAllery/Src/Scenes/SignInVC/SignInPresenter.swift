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
    
    private var userUseCase: UserUseCase
    
    init(view: SignInViewProtocol? = nil,
         router: SignInRouterProtocol,
         network: NetworkServiceProtocol,
         userDefaultsService: UserDefaultsServiceProtocol,
         userUseCase: UserUseCase) {
        self.view = view
        self.router = router
        self.network = network
        self.userDefaultsService = userDefaultsService
        self.userUseCase = userUseCase
    }
    
}

extension SignInPresenter: SignInPresenterProtocol {
    
    func openTabBar() {
        router.openTabBarController()
    }
    
    func signInButtonTap(userName: String,
                         password: String) {
        self.userUseCase.authorization(userName: userName, password: password)
            .observe(on: MainScheduler.instance)
            .subscribe { userModel in
                DispatchQueue.main.sync {
                    self.openTabBar()
                }
            }
            .disposed(by: disposeBag)
    }

    func popViewController(viewController: SignInViewController) {
        router.popViewController(viewController: viewController)
    }
}
