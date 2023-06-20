//
//  AddDataPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 11.06.23.
//

import Foundation
import RxSwift

protocol AddDataPresenterProtocol {
    
    func popViewController(viewController: AddDataViewController)
    func getCurrentDate() -> String
    func mediaObject(name: String,
                     file: Data,
                     dateCreate: String,
                     description: String,
                     new: Bool,
                     popular: Bool)
}

class AddDataPresenter {
    
    weak var view: AddDataVCProtocol?
    var router: AddDataRouterProtocol
    var network: NetworkServiceProtocol
    var disposeBag = DisposeBag()
    
    init(view: AddDataVCProtocol? = nil,
         router: AddDataRouterProtocol,
         mainView: MainViewControllerProtocol? = nil,
         network: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.network = network
    }
}

extension AddDataPresenter: AddDataPresenterProtocol {
    
    func popViewController(viewController: AddDataViewController) {
        router.popViewController(viewController: viewController)
    }
    
    func mediaObject(name: String,
                     file: Data,
                     dateCreate: String,
                     description: String,
                     new: Bool,
                     popular: Bool) {
        network.postMediaObject(file: file,
                                name: name)
        .observe(on: MainScheduler.instance)
        .flatMap({ [weak self] (imageModel) -> Single<ItemModel> in
            guard let self = self,
            let iriId = imageModel.id else {
                return .error(NSError(domain: "", code: 0, userInfo: nil)) }

            return self.network.postImageFile(name: name,
                                              dateCreate: dateCreate,
                                              description: description,
                                              new: new,
                                              popular: popular,
                                              iriId: iriId)
        })
        .subscribe(onSuccess: { [weak self] (itemModel) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                print(itemModel)
                self.router.openTabBarController(index: 0)
                self.view?.showSnackBar()
            }
        }, onFailure: { error in
            print(error)
        }, onDisposed: {
        })
        .disposed(by: disposeBag)
    }

    func getCurrentDate() -> String {
        return FormattedDateString.getCurrentDate()
    }
}
