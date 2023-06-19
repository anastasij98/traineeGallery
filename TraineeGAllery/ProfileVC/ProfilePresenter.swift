//
//  ProfilePresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 08.05.23.
//

import Foundation
import RxSwift

protocol ProfilePresenterProtocol {
    
    /// Обращение к роутеру для открытия экрана настроек(Settings)
    func openSettings()
    
    /// Открытие TabBarController'a
    /// - Parameter index: индекс выбранного экрана 
    func openTabBarViewController(index: Int)
    
    /// View готово к отображению
    func viewIsReady()
    
    func loadMore()
    func getItemsCount() -> Int
    func getItem(index: Int) -> ItemModel
}

class ProfilePresenter {
    
    weak var view: ProfileVCProtocol?
    var router: ProfileRouterProtocol
    var network:NetworkServiceProtocol
    var userDef: UserDefaultsServiceProtocol
    
    var usersImages: [ItemModel] = [ItemModel]()

    var currentPage: Int = 0
    var pageToLoad: Int = 0
    
    var disposeBag = DisposeBag()

    init(view: ProfileVCProtocol? = nil,
         router: ProfileRouterProtocol,
         network: NetworkServiceProtocol,
         userDef: UserDefaultsServiceProtocol) {
        self.view = view
        self.router = router
        self.network = network
        self.userDef = userDef
    }
    
    
    @objc
    func getUsersImages() {
        disposeBag = DisposeBag()
        let userId = userDef.getUsersId()
        network.getUsersImages(userId: userId)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess:{ [weak self] data in
                guard let self = self else { return }
                print(data)
                self.usersImages.append(contentsOf: data.data)
                self.view?.updateCollectionView()
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    
    func openSettings() {
        router.openSettings()
    }
    
    func openTabBarViewController(index: Int) {
        router.openTabBarViewController(index: index)
    }
    
    func viewIsReady() {
        view?.setupView(userName: userDef.getUsersInfo().name,
                        birthday: userDef.getUsersInfo().birthday)
        
        getUsersImages()
    }
    
    func loadMore() {
        getUsersImages()
    }
    
    func getItemsCount() -> Int {
        usersImages.count
    }
    
    func getItem(index: Int) -> ItemModel {
        usersImages[index]
    }
}
