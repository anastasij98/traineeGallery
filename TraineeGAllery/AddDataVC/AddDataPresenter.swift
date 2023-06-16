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
//    func postImage(name: String,
//                   dateCreate: String,
//                   description: String,
//                   new: Bool,
//                   popular: Bool,
//                   image: ImageModel)
    func getCurrentDate() -> String
    func mediaObject(name: String, file: Data)
}

class AddDataPresenter {
    
    weak var view: AddDataVCProtocol?
    var router: AddDataRouterProtocol
    var network: NetworkServiceProtocol
    var disposeBag = DisposeBag()
    init(view: AddDataVCProtocol? = nil,
         router: AddDataRouterProtocol,
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
    
    func mediaObject(name: String, file: Data) {
        network.postMediaObject(file: file, name: name)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess:{ [weak self] imageModel in
                guard let self = self else { return }
                print(imageModel)
            })
            .disposed(by: disposeBag)
    }
//    func postImage(name: String,
//                   dateCreate: String,
//                   description: String,
//                   new: Bool,
//                   popular: Bool,
//                   image: ImageModel) {
//        guard let imageFile = image.file else { return }
//        network.postMediaObject(file: imageFile,
//                                name: name)
//        .observe(on: MainScheduler.instance)
//        .debug()
//        .flatMap({ [weak self] (imageModel) -> Single<ItemModel> in
//            guard let self = self else {
//                return .error(NSError(domain: "", code: 0, userInfo: nil)) }
//
//            print(imageModel)
//
//            return self.network.postImageFile(name: name,
//                                              dateCreate: dateCreate,
//                                              description: description,
//                                              new: new,
//                                              popular: popular,
//                                              image: imageModel)
//        })
//        .subscribe(onSuccess: {_ in
//        })
//        .disposed(by: disposeBag)
//    }
    
    func getCurrentDate() -> String {
        return FormattedDateString.getCurrentDate()
    }
}
