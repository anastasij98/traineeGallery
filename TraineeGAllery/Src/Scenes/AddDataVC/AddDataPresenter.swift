//
//  AddDataPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 11.06.23.
//

import Foundation
import RxSwift

class AddDataPresenter {
    
    weak var view: AddDataVCProtocol?
    var router: AddDataRouterProtocol
    private var fileUseCase: FileUseCase

    var disposeBag = DisposeBag()

    init(view: AddDataVCProtocol? = nil,
         router: AddDataRouterProtocol,
         fileUseCase: FileUseCase) {
        self.view = view
        self.router = router
        self.fileUseCase = fileUseCase
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
                     popular: Bool,
                     viewController: AddDataViewController) {
        
        self.view?.showProgressHUD()
        
        fileUseCase.postMediaObject(file: file,
                                    name: name,
                                    dateCreate: dateCreate,
                                    description: description,
                                    new: new,
                                    popular: popular)
        .observe(on: MainScheduler.instance)
        .subscribe(onSuccess: { [weak self] (itemModel) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                print(itemModel)
                self.view?.showSuccessHUD(completion: { _ in
                    self.router.openTabBarController(index: 0)
                    self.view?.showSnackBar()
                    self.popViewController(viewController: viewController)
                })
            }
        })
        .disposed(by: disposeBag)
    }
    
    func getCurrentDate() -> String {
        return FormattedDateString.getCurrentDate()
    }
}
