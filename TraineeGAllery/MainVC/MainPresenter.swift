//
//  MainPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 04.04.23.
//

import Foundation
import Alamofire
import RxSwift

protocol MainPresenterProtocol {
    
    var mode: SegmentMode { get set }
    
    func didSelectItem(withIndex index: Int)
    func didSelectSegment(withIndex index: Int)
    func getItem(index: Int) -> ItemModel
    func getItemsCount() -> Int
    func loadMore()
    func needIndicatorInFooter() -> Bool
    func onRefreshStarted()
    func viewIsReady()
}

class MainPresenter {

    weak var view: MainViewControllerProtocol?
    var router: MainRouterProtocol
    var network: NetworkServiceProtocol
    
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
    
    // идентификаторы запросов
    var newRequestID: String?
    var popularRequestID: String?
    var requestID: String? {
        get {
            switch mode {
            case .new:
                return newRequestID
            case .popular:
                return popularRequestID
            }
        }
        set {
            switch mode {
            case .new:
                newRequestID = newValue
            case .popular:
                popularRequestID = newValue
            }
        }
    }
    
    var hasMorePages: Bool {
        currentPage <= currentCountOfPages
    }
    
    var isLoading = false
    
    lazy var reachibilityNetwork = NetworkReachabilityManager(host: "www.ya.ru")
    
    init(view: MainViewControllerProtocol? = nil,
         router: MainRouterProtocol,
         network: NetworkService) {
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
                          mode: mode)
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
//            data.responseData { response in
//                print("Status code: \(response.response?.statusCode)")
//                print("Header: \(response.response?.headers)")
//            }
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
    
    func needIndicatorInFooter() -> Bool {
        hasMorePages && getItemsCount() != 0
    }
    
    func onRefreshStarted() {
        currentPage = 0
        requestID = nil
        requestImages.removeAll()
        loadMore()
    }

    func viewIsReady() {
        setupReachibilityManager()
        loadMore()
    }
}
