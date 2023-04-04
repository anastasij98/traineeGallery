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
    
    let id = "cell"
    var mode: SegmentMode = .new
    
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
    
    var hasMorePages: Bool {
        currentPage <= currentCountOfPages
    }
    var isLoading = false
    
    lazy var reachibilityNetwork = NetworkReachabilityManager(host: "www.ya.ru")
    
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
        let segments = [SegmentMode.new.rawValue, SegmentMode.popular.rawValue]
        let view = UISegmentedControl(items: segments)
        view.selectedSegmentIndex = 0
        view.clipsToBounds = false
        view.addTarget(self, action: #selector(changeScreen), for: .valueChanged)
        view.backgroundColor = .white
        view.removeBorder()
        
        return view
    }()
    
    lazy var splitLeftUnderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .customPink
        return view
    }()
    
    lazy var splitRightUnderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .customPink
        return view
    }()
    
    lazy var underlineView: SplitUnderlineView = {
        let view = SplitUnderlineView()
        view.setup(underlinesCount: segmentedControl.numberOfSegments)
        view.setHighlited(viewWithindex: 0)
        return view
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.attributedTitle = NSAttributedString(string: "")
        view.tintColor = .systemMint
        view.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
        
        return view
    }()
    
    let noConnectionStackView: NoConnectionStack = {
            let view = NoConnectionStack()
            return view
        }()
    
    
    let indicatorReuseIdentifier = "indicator"
    let clearReuseIdentifier = "clear"
    
    let backIndicatorImage = UIImage(named: "Vector")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavgationBar()
        setupSegmentedControl()
        setupCollectionView()
        setupCollectionViewLayout()
        updateUnderlineVisibility(hiddenValue: false)
        view.addSubview(noConnectionStackView)
        noConnectionStackView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
//        collectionView.backgroundView = noConnectionStackView
        
        loadMore()
        
        //Presenter
        reachibilityNetwork?.startListening(onUpdatePerforming: { [ weak self ] status in
            guard let self = self else { return }
            switch status {
            case .reachable, .unknown:
                self.collectionView.isHidden = false
                self.noConnectionStackView.isHidden = true
                print("\(status)")
                
                if self.requestImages.isEmpty {
                    self.loadMore()
                }
                
            case .notReachable:
                self.collectionView.isHidden = true
                self.noConnectionStackView.isHidden = false
                print("Network Status: \(status)")
                
            }
        })
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setupNavgationBar() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backIndicatorImage = backIndicatorImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backIndicatorImage
    }
    
    private func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        segmentedControl.addSubviews(splitLeftUnderlineView, splitRightUnderlineView)
        
        splitLeftUnderlineView.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.width.equalTo(segmentedControl.snp.width).dividedBy(segmentedControl.numberOfSegments)
            $0.bottom.equalTo(segmentedControl.snp.bottom)
            $0.leading.equalTo(segmentedControl.snp.leading)
            
        }
        splitRightUnderlineView.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.width.equalTo(segmentedControl.snp.width).dividedBy(segmentedControl.numberOfSegments)
            $0.bottom.equalTo(segmentedControl.snp.bottom)
            $0.trailing.equalTo(segmentedControl.snp.trailing)
        }
        
        view.addSubview(underlineView)
        underlineView.snp.makeConstraints {
            $0.top.equalTo(splitLeftUnderlineView.snp.bottom)
            $0.leading.equalTo(segmentedControl.snp.leading)
            $0.trailing.equalTo(segmentedControl.snp.trailing)
        }
        
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: id)
        
        collectionView.register(IndicatorFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: indicatorReuseIdentifier)
        collectionView.register(ClearFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: clearReuseIdentifier)
        
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
    
    func getAnswerFromRequest(limit: Int = 10, completion: @escaping(Result<JSONModel, Error>) -> ()) {
        pageToLoad = currentPage + 1
        
        let request = URLConfiguration.url + URLConfiguration.api
        var parametrs: Parameters = [
            "page": "\(pageToLoad)",
            "limit": "\(limit)"
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
            self.isLoading = false
            
        }
        
        isLoading = true
    }
    
    @objc
    func getData() {
        getAnswerFromRequest(limit: 10) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.requestImages.append(contentsOf: success.data)
                    //                    self.collectionView.reloadSections([0])
                    self.collectionView.reconfigureItems(at: self.collectionView.indexPathsForVisibleItems)
                    
                    
                    guard let count = success.countOfPages else { return }
                    self.currentCountOfPages = count
                    
                    self.currentPage = self.pageToLoad
                    
                case .failure(let failure):
                    print(failure.localizedDescription)
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
        guard !isLoading, hasMorePages else {
            #if DEBUG
            print("All images are loaded")
            #endif
            return
        }
        getData()
    }
    
    func updateUnderlineVisibility(hiddenValue: Bool) {
        splitLeftUnderlineView.isHidden = hiddenValue
        splitRightUnderlineView.isHidden = !hiddenValue
    }
    
    @objc
    func changeScreen(_ sender: UISegmentedControl) {
        savedCollectionViewOffset = collectionView.contentOffset
        underlineView.setHighlited(viewWithindex: segmentedControl.selectedSegmentIndex)

        
        segmentedControl.selectedSegmentIndex == 0 ? updateUnderlineVisibility(hiddenValue: false) : updateUnderlineVisibility(hiddenValue: true)
//        segmentedControl.selectedSegmentIndex == 0 ? (mode = .new) : (mode = .popular)
        
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
        collectionView.reloadSections([0])
        collectionView.setContentOffset(savedCollectionViewOffset, animated: false)
    }
}
