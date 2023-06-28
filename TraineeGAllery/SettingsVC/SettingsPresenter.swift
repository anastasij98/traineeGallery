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
    var network: NetworkServiceProtocol
    
    let disposeBag = DisposeBag()
    
    init(view: SettingsViewController? = nil,
         router: SettingsRouterProtocol,
         userDef: UserDefaultsServiceProtocol,
         network: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.userDef = userDef
        self.network = network
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
        network.deleteUser(id: usersId)
            .observe(on: MainScheduler.instance)
            .debug()
            .do()
            .subscribe(onSuccess: { [weak self] data in
                print(data)
                self?.router.returnToWelcomeViewController()
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
}
