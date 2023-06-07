//
//  SettingsPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.05.23.
//

import Foundation
import RxSwift

protocol SettingsPresenterProtocol {
    
    func popViewController(viewController: SettingsViewController)
    func viewIsReady()
    func saveNotes()
    func deleteUser()
}

class SettingsPresenter {
    
    weak var view: SettingsViewController?
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
    
    
    func saveNotes() {
        view?.textForSaving(completion: { userName, birthday, email in
            userDef.saveUsersInfo(name: userName, birthday: birthday, email: email)
        })
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
}
