//
//  MainViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.03.23.
//

import UIKit
import SnapKit

protocol MainViewControllerProtocol: AnyObject {
    
    /// В зависимоти от состояния сети показывается либо галерея, либо информация об отсутсвтии сети
    /// - Parameter isConnected: параметр, показывающий наличие/отсутсвие сети
    func connectionDidChange(isConnected: Bool)
    
    /// Скрывает refreshControll
    func hideRefreshControll()
    
    /// Обновление отображения галереи и устанавление последнего положения галереи, которое было открыто пользователем
    /// - Parameter restoreOffset: параметр, показывающий нужно ли устанавливать последнее положение или нет
    func updateView(restoreOffset: Bool)
}

class MainViewController: UISearchController {
    
    enum Identifiers {
        static let cellId = "cell"
        static let indicatorReuseIdentifier = "indicator"
        static let clearReuseIdentifier = "clear"
    }
    
    var presenter: MainPresenterProtocol?
    
    var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
   
    
    //положение галлереи
    var newCollectionViewOffset: CGPoint = CGPoint()
    var popularCollectionViewOffset: CGPoint = CGPoint()
    var savedCollectionViewOffset: CGPoint {
        get {
            switch presenter?.mode ?? .new {
            case .new:
                return newCollectionViewOffset
            case .popular:
                return popularCollectionViewOffset
            }
        }
        set {
            switch presenter?.mode ?? .new {
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
        view.removeBorder()
        view.selectedSegmentIndex = 0
        view.clipsToBounds = false
        view.addTarget(self, action: #selector(changeScreen), for: .valueChanged)
        view.backgroundColor = .white
        view.setTitleTextAttributes([.font : UIFont.robotoRegular(ofSize: 17),
                                     .foregroundColor : UIColor.black],
                                    for: .selected)
        view.setTitleTextAttributes([.font : UIFont.robotoRegular(ofSize: 17),
                                     .foregroundColor : UIColor.mainGrey],
                                    for: .normal)
        
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
    
    lazy var searchController: UISearchBar = {
       let view = UISearchBar()
        view.tintColor = .customDarkGrey

        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewIsReady()
        setupSegmentedControl()
        setupCollectionView()
        setupCollectionViewLayout()
        updateUnderlineVisibility(hiddenValue: false)
        setupNoConnectionStackView()
        
        setupSearchBar()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setupSearchBar() {
        searchController.delegate = self
        self.hidesNavigationBarDuringPresentation = false
        self.navigationItem.titleView = searchController
    }
    
    private func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        segmentedControl.addSubviews(splitLeftUnderlineView, splitRightUnderlineView)

        segmentedControl.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
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
    }
    
    private func setupCollectionView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MainCollectionViewCell.self,
                                forCellWithReuseIdentifier: Identifiers.cellId)
        
        collectionView.register(IndicatorFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Identifiers.indicatorReuseIdentifier)
        collectionView.register(ClearFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Identifiers.clearReuseIdentifier)
        
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
    
    private func setupNoConnectionStackView() {
        view.addSubview(noConnectionStackView)
        noConnectionStackView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
    }
    
    private func updateUnderlineVisibility(hiddenValue: Bool) {
        splitLeftUnderlineView.isHidden = hiddenValue
        splitRightUnderlineView.isHidden = !hiddenValue
    }

    @objc
    func refreshCollectionView() {
        savedCollectionViewOffset = .zero
        presenter?.onRefreshStarted()
        collectionView.reloadData()
    }
    
    @objc
    func changeScreen(_ sender: UISegmentedControl) {
        savedCollectionViewOffset = collectionView.contentOffset
        segmentedControl.selectedSegmentIndex == 0
            ? updateUnderlineVisibility(hiddenValue: false)
            : updateUnderlineVisibility(hiddenValue: true)
    
        presenter?.didSelectSegment(withIndex: segmentedControl.selectedSegmentIndex)
    }
}

extension MainViewController: MainViewControllerProtocol {
    
    func connectionDidChange(isConnected: Bool) {
       collectionView.isHidden = !isConnected
       noConnectionStackView.isHidden = isConnected
    }
    
    func hideRefreshControll() {
        refreshControl.endRefreshing()
    }
    
    func updateView(restoreOffset: Bool) {
//        UIView.performWithoutAnimation {
//            collectionView.reloadSections([0])
//        }
        collectionView.reloadData()
        
        if restoreOffset {
            collectionView.setContentOffset(savedCollectionViewOffset,
                                            animated: false)
        }
    }
}
