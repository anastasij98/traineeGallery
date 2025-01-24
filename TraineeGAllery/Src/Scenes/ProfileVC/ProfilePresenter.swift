//
//  ProfilePresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 08.05.23.
//

import Foundation
import RxSwift

class ProfilePresenter {
    
    weak var view: ProfileVCProtocol?
    var router: ProfileRouterProtocol
    var userDef: UserDefaultsServiceProtocol
    private var fileUseCase: FileUseCase

    var usersImages: [ItemModel] = [ItemModel]()
    var objectsArray = [Data]()
    var selectedObject: Data?
    
    var currentPage: Int = 0
    var pageToLoad: Int = 0
    
    var disposeBag = DisposeBag()

    init(view: ProfileVCProtocol? = nil,
         router: ProfileRouterProtocol,
         userDef: UserDefaultsServiceProtocol,
         fileUseCase: FileUseCase) {
        self.view = view
        self.router = router
        self.userDef = userDef
        self.fileUseCase = fileUseCase
    }
    
    func getUsersImages() {
        usersImages.removeAll()
        disposeBag = DisposeBag()
        let userId = userDef.getUsersId()
        
        fileUseCase.getUsersImages(userId: userId)
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
    
    func getItemsCount() -> Int {
        usersImages.count
    }
    
    func getItem(index: Int) -> ItemModel {
        usersImages[index]
    }
    
    func didSelectObject(withIndex index: Int) {
//        let vc = AddDataConfigurator.getViewController(imageObject: ImageObjectModel(imageData: usersImages[index]))
//        let object = objectsArray[index]
//        view?.setSelectedObject(model: ImageObjectModel(imageData: object))
//        selectedObject = object
    }
}
