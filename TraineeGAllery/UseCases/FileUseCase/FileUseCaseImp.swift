//
//  FileUseCaseImp.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 05.07.23.
//

import Foundation
import RxSwift

class FileUseCaseImp: FileUseCase {

    private let fileGateway: FileGateway
    
    var mode: SegmentMode = .new
    var disposeBag = DisposeBag()
    
    // всего страниц на сервере
    var countOfNewPages: Int = 0
    var countOfPopularPages: Int = 0
    var currentCountOfPages: Int {
        get {
            switch mode {
            case .new:
                return countOfNewPages
            case .popular:
                return countOfPopularPages
            }
        }
        set {
            switch mode {
            case .new:
                countOfNewPages = newValue
            case .popular:
                countOfPopularPages = newValue
            }
        }
    }
    
    // текущая загруженная страница
    var currentNewPage: Int = 0
    var currentPopularPage: Int = 0
    var currentPage: Int {
        get {
            switch mode {
            case .new:
                return currentNewPage
            case .popular:
                return currentPopularPage
            }
        }
        set {
            switch mode {
            case .new:
                currentNewPage = newValue
            case .popular:
                currentPopularPage = newValue
            }
        }
    }
    
    //страница на загрузку
    var newPageToLoad: Int = 0
    var popularPageToLoad: Int = 0
    var pageToLoad: Int {
        get {
            switch mode {
            case .new:
                return newPageToLoad
            case .popular:
                return popularPageToLoad
            }
        }
        set {
            switch mode {
            case .new:
                newPageToLoad = newValue
            case .popular:
                popularPageToLoad = newValue
            }
        }
    }

    // TODO: дргать подобную ину из юскейса
    var hasMorePages: Bool {
        return currentPage <= currentCountOfPages
    }
    var isLoading = false
    
    init(_ fileGateway: FileGateway) {
        self.fileGateway = fileGateway
    }

    func getImages(limit: Int, mode: SegmentMode?, searchText: String?) -> Single<ResponseModel> {
        pageToLoad = currentPage + 1
        return fileGateway.getImages(limit: limit,
                              pageToLoad: pageToLoad,
                              mode: mode,
                              searchText: searchText)
        .do(onSuccess:{ [weak self] data in
            guard let self = self else { return }
            guard let count = data.countOfPages else {
                return
            }
            self.currentCountOfPages = count
            self.currentPage = self.pageToLoad
        }, onSubscribe: { [weak self] in
            guard let self = self else { return }
            
            self.isLoading = true
        }, onDispose: { [weak self]  in
            guard let self = self else { return }
            self.isLoading = false
        })
    }
    
    func getImageFile(name: String) -> Single<Data> {
        fileGateway.getImageFile(name: name)
    }
    
    func postMediaObject(file: Data, name: String, dateCreate: String, description: String, new: Bool, popular: Bool) -> Single<ItemModel> {
        fileGateway.postMediaObject(file: file, name: name)
            .flatMap({ [weak self] (imageModel) -> Single<ItemModel> in
                guard let self = self,
                      let iriId = imageModel.id else {
                    return .error(NSError(domain: "", code: 0, userInfo: nil)) }
                
                return fileGateway.postImageFile(name: name,
                                                 dateCreate: dateCreate,
                                                 description: description,
                                                 new: new,
                                                 popular: popular,
                                                 iriId: iriId)
            })
    }
    
    func getUsersImages(userId: Int) -> Single<ResponseModel> {
        fileGateway.getUsersImages(userId: userId)
    }
}
