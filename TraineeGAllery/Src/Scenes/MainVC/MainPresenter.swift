//
//  MainPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 04.04.23.
//

import Foundation
import Alamofire
import RxSwift

class MainPresenter {

    weak var view: MainViewControllerProtocol?
    var router: MainRouterProtocol
    
    var searchedText: String = .init()
    var mode: SegmentMode = .new
    
    var disposeBag = DisposeBag()

    private var fileUseCase: FileUseCase

    // TODO: все таки избавиться от простыней
    // загруженные картинки
    var newImages = [ItemModel]()
    var popularImages = [ItemModel]()
    var requestImages: [ItemModel] {
        get {
            switch mode {
            case .new:
                return newImages
            case .popular:
                return popularImages
            }
        }
        set {
            switch mode {
            case .new:
                newImages = newValue
            case .popular:
                popularImages = newValue
            }
        }
    }

////    var wasResultProcessed = false
////
////    var hasMorePages: Bool {
////        print("||", currentPage, currentCountOfPages)
////        return (currentPage <= currentCountOfPages) || !wasResultProcessed
////    }
    
    lazy var reachibilityNetwork = NetworkReachabilityManager(host: "www.ya.ru")
    
    init(view: MainViewControllerProtocol? = nil,
         router: MainRouterProtocol,
         fileUseCase: FileUseCase) {
        self.view = view
        self.router = router
        self.fileUseCase = fileUseCase
    }
    
    func setupReachibilityManager() {
        reachibilityNetwork?.startListening(onUpdatePerforming: { [ weak self ] status in
            guard let self = self else { return }
            switch status {
            case .reachable, .unknown:
                self.view?.connectionDidChange(isConnected: true)
                
                print("\(status)")
                
                if self.requestImages.isEmpty {
                    self.loadMore()
                }

            case .notReachable:
                self.view?.connectionDidChange(isConnected: false)
                print("Network Status: \(status)")
            }
        })
    }
    
    @objc
    func getData() {
        disposeBag = DisposeBag()
        fileUseCase.getImages(limit: 10,
                              mode: mode,
                              searchText: nil)
        .observe(on: MainScheduler.instance)
        .do(onDispose: { [weak self]  in
            guard let self = self else { return }
            self.view?.hideRefreshControll()
        })
        .subscribe(onSuccess:{ [weak self] data in
            guard let self = self else { return }
            self.requestImages.append(contentsOf: data.data)
            self.view?.updateView(restoreOffset: false)
        }, onFailure: { error in
            print(error)
        })
        .disposed(by: disposeBag)
    }
    
    @objc
    func getSearchData(searchText: String?) {
        disposeBag = DisposeBag()
        fileUseCase.getImages(limit: 10,
                              mode: mode,
                              searchText: searchText)
        .observe(on: MainScheduler.instance)
        .do(onDispose: { [weak self]  in
            guard let self = self else { return }
            self.view?.hideRefreshControll()
        })
        .subscribe(onSuccess:{ [weak self] data in
            guard let self = self else { return }
            self.requestImages.append(contentsOf: data.data)
            self.view?.updateView(restoreOffset: false)
        }, onFailure: { error in
            print(error)
        })
        .disposed(by: disposeBag)
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    func didSelectItem(withIndex index: Int) {
        router.openDetailedViewController(model: requestImages[index])
    }
    
    func didSelectSegment(withIndex index: Int) {
        switch index {
        case 0:
            mode = .new
            
        case 1:
            mode = .popular
            
        default:
            mode = .new
        }
        
        if requestImages.isEmpty {
            loadMore()
        }
        view?.updateView(restoreOffset: true)
    }
    
    func getItemsCount() -> Int {
        requestImages.count
    }
    
    func getItem(index: Int) -> ItemModel {
        requestImages[index]
    }
    
    func loadMore() {
        guard !fileUseCase.isLoading, fileUseCase.hasMorePages else {
#if DEBUG
            print("All images are loaded")
#endif
            return
        }
        getData()
    }
    
    func loadMoreSearched(searchText: String) {
        guard !fileUseCase.isLoading, fileUseCase.hasMorePages else {

#if DEBUG
            print("All images are loaded")
#endif
            return
        }
        getSearchData(searchText: searchText)
    }

    func needIndicatorInFooter() -> Bool {
////        if searchedText.isEmpty  {
//        print("||", hasMorePages)
//            return hasMorePages && getItemsCount() != 0
////        } else {
////            if hasMorePages && getItemsCount() == 10 {
////                return true
////            } else if getItemsCount() <= 10 {
////                return false
////            } else {
////                return false
////            }
////        }
    if searchedText.isEmpty  {
        return fileUseCase.hasMorePages && getItemsCount() != 0
        } else {
            if fileUseCase.hasMorePages && getItemsCount() == 10 {
                return true
            } else if getItemsCount() <= 10 {
                return false
            } else {
                return false
            }
        }
    }
    
    func onRefreshStarted() {
        fileUseCase.currentPage = 0
        requestImages.removeAll()
        loadMore()
    }
    
    func viewIsReady() {
        setupReachibilityManager()
        loadMore()
    }
    
    func resetValues() {
        fileUseCase.pageToLoad = 0
        fileUseCase.currentPage = 0
        fileUseCase.currentCountOfPages = 0
    }
    
    func removeAllSearchedImages() {
        requestImages.removeAll()
    }
}
