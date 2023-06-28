//
//  DetailedPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 05.04.23.
//

import Foundation
import RxSwift

class DetailedPresenter {
    
    weak var view: DetailedViewControllerProtocol?
    var networkService: NetworkServiceProtocol
    var model: ItemModel
    var taskIdentifier: String?
    
    var disposeBag: DisposeBag = .init()
    
    
    init(view: DetailedViewControllerProtocol? = nil,
         network: NetworkServiceProtocol,
         model: ItemModel) {
        self.view = view
        self.networkService = network
        self.model = model
    }
    
    func getFormattedDateString() -> String {
        guard let date = model.date else {
            return "" }
        return FormattedDateString.getFormattedDateString(string: date)
    }
    
    func downloadImageFile() {
        guard let imageName = model.image?.name else {
            return
        }
        networkService.getImageFile(name: imageName)
            .observe(on: MainScheduler.instance)
            .debug()
            .subscribe(onSuccess: { [weak self] data in
                guard let self = self else { return }
                self.view?.setImage(data: data)
            }, onFailure: { error in
                
            })
            .disposed(by: disposeBag)
    }
}

extension DetailedPresenter: DetailedPresenterProtocol {
    
    func viewIsReady() {
        // Устанавливаем во вью ту информацию, которая уже есть
        view?.setupView(name: model.name ?? .init(),
                        user: model.user ?? "",
                        description: model.description ?? String(),
                        date: getFormattedDateString())
        // Начинаем загрузку картинки
        downloadImageFile()
    }
}
