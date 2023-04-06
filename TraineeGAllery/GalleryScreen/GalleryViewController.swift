//
//  ViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.03.23.
//

import UIKit
import SnapKit

protocol ViewControllerProtocol: AnyObject {
    
    func connectionDidChange(isConnected: Bool)
    func hideRefreshControll()
    func updateView(restoreOffset: Bool)
}

class ViewController: UIViewController {
    
    enum Identifiers {
        static let cellId = "cell"
        static let indicatorReuseIdentifier = "indicator"
        static let clearReuseIdentifier = "clear"
    }
    
    var presenter: GalleryPresenterProtocol?
    
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
                                     .foregroundColor : UIColor.customGrey],
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
    
    let backIndicatorImage = UIImage(named: "Vector")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewIsReady()
        
        view.backgroundColor = .white
        setupNavgationBar()
        setupSegmentedControl()
        setupCollectionView()
        setupCollectionViewLayout()
        updateUnderlineVisibility(hiddenValue: false)
        setupNoConnectionStackView()
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
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CollectionViewCell.self,
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

    @objc
    func refreshCollectionView() {
        savedCollectionViewOffset = .zero
        presenter?.onRefreshStarted()
        collectionView.reloadData()
    }
    
    func updateUnderlineVisibility(hiddenValue: Bool) {
        splitLeftUnderlineView.isHidden = hiddenValue
        splitRightUnderlineView.isHidden = !hiddenValue
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

extension ViewController: ViewControllerProtocol {
    
    func connectionDidChange(isConnected: Bool) {
       collectionView.isHidden = !isConnected
       noConnectionStackView.isHidden = isConnected
    }
    
    func hideRefreshControll() {
        refreshControl.endRefreshing()
    }
    
    func updateView(restoreOffset: Bool) {
        collectionView.reloadSections([0])
        
        if restoreOffset {
            collectionView.setContentOffset(savedCollectionViewOffset,
                                            animated: false)
        }
    }
}
