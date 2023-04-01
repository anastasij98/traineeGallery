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
    
    var imagesPerPage = 10
    var hasMorePages: Bool {
        currentPage <= currentCountOfPages
    }
    var isLoadingRightNow = false

    //положение галлереи
    var newCollectionViewOffset: CGPoint = CGPoint()
    var popularCollectionViewOffset: CGPoint = CGPoint()
    var savedCollectionViewOffset: CGPoint {
        get {
            switch mode {
            case .new:
                return newCollectionViewOffset
            case .popular:
                return popularCollectionViewOffset
            }
        }
        set {
            switch mode {
            case .new:
                newCollectionViewOffset = newValue
            case .popular:
                popularCollectionViewOffset = newValue
            }
        }
    }
        
    lazy var segmentedControl: UISegmentedControl = {
        let segmentItems = ["New", "Popular"]
        let view = UISegmentedControl(items: segmentItems)
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(changeScreen), for: .valueChanged)
        view.backgroundColor = .white
        view.removeBorder()
        view.highlightSelectedSegment()

        return view
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.attributedTitle = NSAttributedString(string: "")
        view.tintColor = .systemMint
        view.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)

        return view
    }()

    var footerReuseIdentifier = "footer"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavgationBar()
        setupSegmentedControl()
        setupCollectionView()
        setupCollectionViewLayout()

        loadMore()

        collectionView.register(BlackFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerReuseIdentifier)
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).footerReferenceSize = CGSize(width: collectionView.bounds.width, height: 50)

        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()

        
    }

    private func setupNavgationBar() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Vector")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Vector")
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
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: id)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        
    }
    
    private func setupCollectionViewLayout() {
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(5)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    func getAnswerFromRequest(completion: @escaping(Result<JSONModel, Error>) -> ()) {
        pageToLoad = currentPage + 1

        let request = URLConfiguration.url + URLConfiguration.api
        var parametrs: Parameters = [
            "page": "\(pageToLoad)",
            "limit": "\(imagesPerPage)"
        ]
        
        switch mode {
        case .new:
            parametrs["new"] = "true"
            print(pageToLoad)

        case .popular:
            parametrs["popular"] = "true"
            print(pageToLoad)

        }

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
        savedCollectionViewOffset = .zero
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
         savedCollectionViewOffset = collectionView.contentOffset
        switch segmentedControl.selectedSegmentIndex {
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
        segmentedControl.underlinePosition()

        collectionView.reloadSections([0])
        collectionView.setContentOffset(savedCollectionViewOffset, animated: false)

    }
}
