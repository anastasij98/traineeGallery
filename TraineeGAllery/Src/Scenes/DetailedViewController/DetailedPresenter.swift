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
    var model: ItemModel
    private var fileUseCase: FileUseCase

    var disposeBag: DisposeBag = .init()
    
    
    init(view: DetailedViewControllerProtocol? = nil,
         model: ItemModel,
         fileUseCase: FileUseCase) {
        self.view = view
        self.model = model
        self.fileUseCase = fileUseCase
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
        
        fileUseCase.getImageFile(name: imageName)
            .observe(on: MainScheduler.instance)
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
