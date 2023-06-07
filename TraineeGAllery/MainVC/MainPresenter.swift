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
    var network: NetworkServiceProtocol
    
    var searchedText: String = .init()
    var mode: SegmentMode = .new
    
    var disposeBag = DisposeBag()

    
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
    
//    var wasResultProcessed = false
//
//    var hasMorePages: Bool {
//        print("||", currentPage, currentCountOfPages)
//        return (currentPage <= currentCountOfPages) || !wasResultProcessed
//    }

    var hasMorePages: Bool {
        return currentPage <= currentCountOfPages
    }
    
    var isLoading = false
    
    lazy var reachibilityNetwork = NetworkReachabilityManager(host: "www.ya.ru")
    
    init(view: MainViewControllerProtocol? = nil,
         router: MainRouterProtocol,
         network: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.network = network
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
        pageToLoad = currentPage + 1
        network.getImages(limit: 10,
                          pageToLoad: pageToLoad,
                          mode: mode,
                          searchText: nil)
        .observe(on: MainScheduler.instance)
        .debug()
        .do(onSubscribe: { [weak self] in
            guard let self = self else { return }

            self.isLoading = true
        }, onDispose: { [weak self]  in
            guard let self = self else { return }
            self.isLoading = false
            self.view?.hideRefreshControll()
        })
        .subscribe(onSuccess:{ [weak self] data in
            guard let self = self else { return }
//            self.wasResultProcessed = true
            self.requestImages.append(contentsOf: data.data)
            guard let count = data.countOfPages else {
                return
            }
            self.currentCountOfPages = count
            self.currentPage = self.pageToLoad
            self.view?.updateView(restoreOffset: false)
        }, onFailure: { error in
            print(error)
        })
        .disposed(by: disposeBag)
    }
    
    @objc
    func getSearchData(searchText: String?) {
        disposeBag = DisposeBag()
        pageToLoad = currentPage + 1

        network.getImages(limit: 10,
                          pageToLoad: pageToLoad,
                          mode: mode,
                          searchText: searchText)
        .observe(on: MainScheduler.instance)
        .debug()
        .do(onSubscribe: { [weak self] in
            guard let self = self else { return }
            self.isLoading = true
        }, onDispose: { [weak self]  in
            guard let self = self else { return }
            self.isLoading = false
            self.view?.hideRefreshControll()
        })
        .delaySubscription(.seconds(1), scheduler: MainScheduler.instance)
        .subscribe(onSuccess:{ [weak self] data in
            guard let self = self else { return }
//            self.wasResultProcessed = true
            self.requestImages.append(contentsOf: data.data)
            self.view?.updateView(restoreOffset: false)
            guard let count = data.countOfPages else { return }
            self.currentCountOfPages = count
            self.currentPage = self.pageToLoad
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
        guard !isLoading, hasMorePages else {
#if DEBUG
            print("All images are loaded")
#endif
            return
        }
        getData()
    }
    
    func loadMoreSearched(searchText: String) {
        guard !isLoading, hasMorePages else {

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
            return hasMorePages && getItemsCount() != 0
        } else {
            if hasMorePages && getItemsCount() == 10 {
                return true
            } else if getItemsCount() <= 10 {
                return false
            } else {
                return false
            }
        }
    }
    
    func onRefreshStarted() {
        currentPage = 0
        requestImages.removeAll()
        loadMore()
    }
    
    func viewIsReady() {
        setupReachibilityManager()
        loadMore()
    }
    
    func resetValues() {
        pageToLoad = 0
        currentPage = 0
        currentCountOfPages = 0
    }
    
    func removeAllSearchedImages() {
        requestImages.removeAll()
    }
}
