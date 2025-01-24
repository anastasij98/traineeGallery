//
//  SettingsPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.05.23.
//

import Foundation
import RxSwift

class SettingsPresenter {
    
    weak var view: SettingsVCProtocol?
    var router: SettingsRouterProtocol
    var userDef: UserDefaultsServiceProtocol
    
    let disposeBag = DisposeBag()
    
    private var userUseCase: UserUseCase
    
    init(view: SettingsViewController? = nil,
         router: SettingsRouterProtocol,
         userDef: UserDefaultsServiceProtocol,
         userUseCase: UserUseCase) {
        self.view = view
        self.router = router
        self.userDef = userDef
        self.userUseCase = userUseCase
    }
}


extension SettingsPresenter: SettingsPresenterProtocol {
    
    func popViewController(viewController: SettingsViewController) {
        router.popViewController(viewController: viewController)
    }
    
    func viewIsReady() {
        view?.setupView(userName: userDef.getUsersInfo().name,
                        birthday: userDef.getUsersInfo().birthday,
                        email: userDef.getUsersInfo().email)
    }
    
    func saveUsersChanges() {
        print("Saved")
    }
    
    func deleteUser() {
        let usersId = userDef.getUsersId()
        print(usersId)
        self.userUseCase.deleteUser(id: usersId)
            .observe(on: MainScheduler.instance)
            .subscribe (onCompleted: {
                self.router.returnToWelcomeViewController()
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func signOut() {
        userDef.removeTokensAndUsersInfo()
        router.returnToWelcomeViewController()
    }
    
    func setDeleteAlertController() {
        guard let view = self.view else { return }
        view.alertControllerWithLeftButton(title: "Confirmation",
                                           message: AlertCases.delete.rawValue,
                                           leftButtonTitle: "Delete",
                                           leftButtonAction: view.deleteUser)
    }
    
    func setCancelAlertController() {
        guard let view = self.view else { return }
        view.alertControllerWithLeftButton(title: "Confirmation",
                                           message: AlertCases.cancel.rawValue,
                                           leftButtonTitle: "Exit",
                                           leftButtonAction: view.popViewController)
    }
    
    func changePassword(oldPassword: String,
                        newPassword: String) {
        let id = String(userDef.getUsersId())
        print(">>> id", id)
        print(">>> oldPassword", oldPassword)
        print(">>> newPassword", newPassword)
        self.userUseCase.changePassword(id: id,
                                        oldPassword: oldPassword,
                                        newPassword: newPassword)
        .observe(on: MainScheduler.instance)
        .subscribe(onSuccess: { [weak self] response in
            guard let self = self else {
                return
            }
            print(response)
        }, onFailure: { error in
            print(error)
        })
        .disposed(by: disposeBag)
    }
}
