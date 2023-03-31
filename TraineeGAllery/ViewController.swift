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

//    lazy var activityIndicator = UIView()
    
    lazy var activityIndicator: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "Ellipse")
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavgationBar()
        setupSegmentedControl()
        setupCollectionView()
//        setupActivity()
        loadMore()

    }
    private func setupActivity() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
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
        
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: id)
        
        collectionView.register(UITableViewHeaderFooterView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: "Footer")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(5)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
//            $0.bottom.equalTo(activityIndicator.snp.top)

        }
        collectionView.refreshControl = refreshControl
    }


    func getAnswerFromRequest(completion: @escaping(Result<JSONModel, Error>) -> ()) {
        let request = URLConfiguration.url + URLConfiguration.api
        pageToLoad = currentPage + 1
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
            self.activityIndicator.stopRotating()
            self.activityIndicator.removeFromSuperview()

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
        collectionView.reloadSections([0])
        collectionView.setContentOffset(savedCollectionViewOffset, animated: false)

    }
}
//MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedVC = DetailedVC()
        detailedVC.model = requestImages[indexPath.item]
        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItemIndex = requestImages.count - 1
        if indexPath.item == lastItemIndex {
            loadMore()
            setupActivity()
            activityIndicator.startRotating()
        }
    }
     
}
//MARK: - UICollectionViewDataSource
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
//MARK: -  UICollectionViewDelegateFlowLayout
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
   
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                            withReuseIdentifier: "Footer", for: indexPath)
        footer.backgroundColor = .green


       return footer
    }
    
}

//MARK: - extension UIView
extension UIView {
    
    func startRotating(duration: Double = 1) {
        let kAnimationKey = "rotation"
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            
            animate.fromValue = 0.0
            animate.toValue = Float(Double.pi * 2.0)
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    
    func stopRotating() {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
}
