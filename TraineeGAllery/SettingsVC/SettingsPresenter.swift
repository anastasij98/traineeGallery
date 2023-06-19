//
//  SettingsPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.05.23.
//

import Foundation
import RxSwift

protocol SettingsPresenterProtocol {
    
    /// Закрытие экрана Settings
    /// - Parameter viewController: viewController, который надо закрыть
    func popViewController(viewController: SettingsViewController)
    
    /// ViewController готов к отображению
    func viewIsReady()
    
    /// Сохранение данных, которые изменил пользователь
    func saveUsersChanges(email: String,
                          phone: String,
                          username: String,
                          birthday: String)
    
    /// Метод, отправляющий запрос на удаление пользователя
    func deleteUser()
    
    /// Метод, позволяющий выйти пользователю из своего профиля
    func signOut()
    
    func setCancelAlertController()
    func setDeleteAlertController()
}

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
    
    func saveUsersChanges(email: String,
                          phone: String,
                          username: String,
                          birthday: String) {
        let usersID = userDef.getUsersId()
        let formattedBirthday = FormattedDateString.setFormattedDateString(string: birthday)
        network.updateUsersInfo(usersId: usersID,
                                email: email,
                                phone: phone,
                                fullName: username,
                                username: username,
                                birthday: formattedBirthday,
                                roles: ["ROLE_USER"])
        .observe(on: MainScheduler.instance)
        .subscribe(onSuccess: { [weak self] usersModel in
            guard let self = self else { return }
            self.view?.textForSaving(completion: { userName, birthday, email in
                self.userDef.saveUsersInfo(name: userName, birthday: birthday, email: email)
            })
        })
        .disposed(by: disposeBag)
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
