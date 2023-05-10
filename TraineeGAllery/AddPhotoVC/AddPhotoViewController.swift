//
//  AddPhotoViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit
import SnapKit

protocol AddPhotoVCProtocol: AnyObject {
    
    
}

class AddPhotoViewController: UIViewController, UIScrollViewDelegate {
    
    var presenter: AddPhotoPresenterProtocol?
    var id = "addPhoto"
    
    var img: UIView?
    
    lazy var scrollView: UIScrollView = {
        var view = UIScrollView()
        view = UIScrollView(frame: .zero)
        view.isScrollEnabled = true
        view.scrollsToTop = false
        
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        
        return view
    }()
    
    lazy var imageView: UIView = {
        let view = UIView()
//        view.image = UIImage(named: "cat2")
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .customLightGrey
        
        return view
    }()
    
    lazy var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGrey
        
        return view
    }()
    
    lazy var selectPhotoLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .robotoRegular(ofSize: 15)
        view.textAlignment = .left
        view.text = "Select photo:"
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: UICollectionViewFlowLayout())
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupScrollAndStack()
        navigationBar()
    }
    
    func navigationBar() {
        let rightButton = UIBarButtonItem(title: "Next",
                                          style: .plain,
                                          target: self,
                                          action: #selector(addData))
        rightButton.setTitleTextAttributes([.font : UIFont.robotoBold(ofSize: 15),
                                            .foregroundColor : UIColor.customPink],
                                           for: .normal)
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setupScrollAndStack() {
        scrollView.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: id)
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(imageView, selectPhotoLabel, collectionView)
        
        imageView.addSubview(underLine)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }

        stackView.snp.makeConstraints {
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(view.snp.width)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
        
        underLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalTo(imageView.snp.width)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
        
        selectPhotoLabel.snp.makeConstraints {
            $0.height.equalTo(42)
            $0.leading.equalTo(stackView.snp.leading)
        }
        
        collectionView.snp.makeConstraints {
            
            $0.height.equalTo(view.safeAreaLayoutGuide.snp.width)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
        
    }
    
    @objc
    func addData() {
        presenter?.addData()
    }
}

extension AddPhotoViewController: AddPhotoVCProtocol {

    
}
