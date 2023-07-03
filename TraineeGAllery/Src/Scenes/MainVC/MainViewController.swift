//
//  MainViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.03.23.
//

import UIKit
import SnapKit

// TODO: не ремувать/или что ты там делаешь, а прятать таблицу, когда нет инета ✅

class MainViewController: UISearchController {
    
    enum Identifiers {
        static let cellId = R.string.localization.cellIdMain()
        static let indicatorReuseIdentifier = R.string.localization.indicatorId()
        static let clearReuseIdentifier = R.string.localization.clearReuseId()
    }
    
    var presenter: MainPresenterProtocol?
    
    var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    // TODO: если каеф - можешь перепсать на 1 переменную оффсет таблицы
//
//    func changeSavedCollectionOffset() {
//        let oldOffset = savedCollectionViewOffset
//        savedCollectionViewOffset = newValue
//    }
    
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
        view.addTarget(self,
                       action: #selector(changeScreen),
                       for: .valueChanged)
        view.backgroundColor = .white
        view.setTitleTextAttributes([.font : R.font.robotoRegular(size: 18),
                                     .foregroundColor : UIColor.galleryBlack],
                                    for: .selected)
        view.setTitleTextAttributes([.font : R.font.robotoRegular(size: 18),
                                     .foregroundColor : UIColor.galleryGrey],
                                    for: .normal)
        
        return view
    }()
    
    // TODO: не плохая точка роста, если эт линии будут привантыми свойствами внутри сегмента и isHidden будет меняться в зависиости от текуего сегмента
    
    lazy var splitLeftUnderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .galleryMain
        
        return view
    }()
    
    lazy var splitRightUnderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .galleryMain
        
        return view
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.attributedTitle = NSAttributedString(string: .init())
        view.tintColor = .galleryBlue
        view.addTarget(self,
                       action: #selector(refreshCollectionView),
                       for: .valueChanged)
        
        return view
    }()
    
    let noConnectionStackView: NoConnectionStack = {
        let view = NoConnectionStack()
        
        return view
    }()
    
    lazy var searchController: UISearchBar = {
       let view = UISearchBar()
        view.tintColor = .galleryGrey
        view.placeholder = R.string.localization.search()

        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewIsReady()
        setupSegmentedControl()
        addSubviews()
        configureLayout()
        setupCollectionView()
        updateUnderlineVisibility(hiddenValue: true)
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(underlineColor: .clear)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.collectionViewLayout.invalidateLayout()
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
            ? updateUnderlineVisibility(hiddenValue: true)
            : updateUnderlineVisibility(hiddenValue: false)
    
        presenter?.didSelectSegment(withIndex: segmentedControl.selectedSegmentIndex)
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
    
    private func addSubviews() {
        view.backgroundColor = .white
        view.addSubviews(collectionView, noConnectionStackView)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MainCollectionViewCell.self,
                                forCellWithReuseIdentifier: Identifiers.cellId)
        
        collectionView.register(IndicatorFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Identifiers.indicatorReuseIdentifier)
        collectionView.register(ClearFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Identifiers.clearReuseIdentifier)
        
        collectionView.refreshControl = refreshControl
    }
    
    private func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(5)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        noConnectionStackView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
    }

    private func updateUnderlineVisibility(hiddenValue: Bool) {
        if hiddenValue {
            splitLeftUnderlineView.backgroundColor = .galleryMain
            splitRightUnderlineView.backgroundColor = .galleryLightGrey
        } else {
            splitLeftUnderlineView.backgroundColor = .galleryLightGrey
            splitRightUnderlineView.backgroundColor = .galleryMain
        }
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
