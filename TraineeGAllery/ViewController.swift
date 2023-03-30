//
//  ViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.03.23.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {
    
    var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    var id = "cell"
    
    var mode = SegmentMode.new

    
    // загруженные картинки
    var newImages: [ItemModel] = []
    var popularImages: [ItemModel] = []
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

    var totalItems: Int {
        requestImages.count
    }
    
    var imagesPerPage = 10
//    var countOfPages: Int {
//        get {
//            totalItems / imagesPerPage
//        }
//    }

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
//    var currentPage = 0
    
    // текущие загруженные страницы
    private var currentPageStorage: (new: Int, popular: Int) = (0, 0)
    //    var currentNewPage = 0
    //    var currentPopularPage = 0
    var currentPage: Int {
        get {
            switch mode {
            case .new:
                return currentPageStorage.new
            case .popular:
                return currentPageStorage.popular
            }
        }
        set {
            switch mode {
            case .new:
                currentPageStorage.new = newValue
            case .popular:
                currentPageStorage.popular = newValue
            }
        }
    }
    
    //страница на загрузку
    private var pageToLoadStorage: (new: Int, popular: Int) = (0, 0)
    var pageToLoad: Int {
        get {
            switch mode {
            case .new:
                return pageToLoadStorage.new
            case .popular:
                return pageToLoadStorage.popular
            }
        }
        set {
            switch mode {
            case .new:
                pageToLoadStorage.new = newValue
            case .popular:
                pageToLoadStorage.popular = newValue
            }
        }
    }
    
    
    var hasMorePages: Bool {
        currentPage <= currentCountOfPages
    }
    
    
    var isLoadingRightNow = false
        
    lazy var segmentedControl: UISegmentedControl = {
        let segmentItems = ["New", "Popular"]
        let view = UISegmentedControl(items: segmentItems)
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(changeScreen), for: .valueChanged)
        view.backgroundColor = .white
        view.removeBorder()
        
        return view
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.attributedTitle = NSAttributedString(string: "")
        view.tintColor = .systemMint
        view.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavgationBar()
        setupSegmentedControl()
        setupCollectionView()
        loadMore()
    }
    
    private func setupNavgationBar() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "leftArrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "leftArrow")
    }
    
    private func setupSegmentedControl() {
        view.addSubview(segmentedControl)

        segmentedControl.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
            
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: id)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(5)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        collectionView.refreshControl = refreshControl
    }


    func getAnswerFromRequest(completion: @escaping(Result<JSONModel, Error>) -> ()) {
//        pageToLoad = currentPage + 1
//        let newValue: Bool
//        let popularValue: Bool

        let request = URLConfiguration.url + URLConfiguration.api
        pageToLoad = currentPage + 1
        let parametrs: Parameters = [
            "page": "\(pageToLoad)",
            "limit": "\(imagesPerPage)",
            mode.rawValue: "true"
        ]
        
//        switch mode {
//        case .new:
//            parametrs["new"] = "true"
//            print(pageToLoad)
//
//        case .popular:
//            parametrs["popular"] = "true"
//            print(pageToLoad)
//
//
//        }

        AF.request(request, method: .get, parameters: parametrs).responseData { response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(JSONModel.self, from: data)
                    completion(.success(result))
                } catch let decodinError {
                    completion(.failure(decodinError))
                }
            } else if let error = response.error {
                completion(.failure(error))
            } else {
                    completion(.failure(NSError(domain: "Get nothing", code: 0)))
                }
            self.isLoadingRightNow = false
            }
        isLoadingRightNow = true
        }
    
   @objc
   func getData() {
        getAnswerFromRequest { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.requestImages.append(contentsOf: success.data)
                    self.collectionView.reloadSections([0])
                    
                    guard let count = success.countOfPages else { return }
                    self.currentCountOfPages = count
                    
                    self.currentPage = self.pageToLoad


                case .failure(let failure):
                    print(failure)
                }
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc
    func refreshCollectionView() {
        currentPage = 0
        requestImages.removeAll()
        collectionView.reloadData()
        loadMore()
    }
    
    func loadMore() {
        guard !isLoadingRightNow, hasMorePages else {
            return print("All images are loaded")
        }
        getData()
    }
    
    @objc
    func changeScreen(_ sender: UISegmentedControl) {
        guard let newMode = SegmentMode(index: sender.selectedSegmentIndex) else {
            return
        }
        
        mode = newMode
        
//        switch segmentedControl.selectedSegmentIndex {
//        case 0:
//            mode = .new
//        case 1:
//            mode = .popular
//
//        default:
//            mode = .new
//        }
        
        if requestImages.isEmpty {
            loadMore()
        }
        collectionView.contentOffset = .zero
        collectionView.reloadSections([0])
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedVC = DetailedVC()
        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItemIndex = requestImages.count - 1
        if indexPath.item == lastItemIndex {
            loadMore()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return requestImages.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
            
            let request = URLConfiguration.url + URLConfiguration.media + (requestImages[indexPath.item].image.name ?? "")
            let model = CollectionViewCellModel(imageURL: URL(string: request))
            item.setupCollectionItem(model: model)
            item.backgroundColor = .customGrey
     
            return item
        }
        
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsInRow: CGFloat = 2
        let sidePadding: CGFloat = 16
        let paddingsInRow: CGFloat = (itemsInRow - 1) * 9 + (sidePadding * 2)
        let allowedWidth = view.frame.width - paddingsInRow
        let itemsWidth = allowedWidth / itemsInRow
        return CGSize(width: itemsWidth, height: itemsWidth )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
    }
    
}
