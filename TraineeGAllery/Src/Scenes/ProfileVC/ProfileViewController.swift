//
//  ProfileViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit
import SnapKit

//TODO: релоад таблицы во вьюВиллАппеар ✅
class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    var presenter: ProfilePresenterProtocol?
    var profileCellId = R.string.localization.profileCellId()
    var userImagesID = R.string.localization.userImagesID()
    
    var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: UICollectionViewFlowLayout())

        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        var view = UIScrollView()
        view = UIScrollView(frame: .zero)
        view.isScrollEnabled = true
        view.scrollsToTop = false
        
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalSpacing
        view.spacing = 20
        
        return view
    }()
    
    lazy var infoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .equalSpacing
        view.spacing = 4
        
        return view
    }()
    
    lazy var userPhotoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = R.image.logo2()
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.galleryGrey.cgColor

        return view
    }()
    
    lazy var userNameLabel: UILabel = {
        let view = UILabel()
        view.textColor = .galleryBlack
        view.font = R.font.robotoRegular(size: 18)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        
        return view
    }()
    
    lazy var birthdayLabel: UILabel = {
        let view = UILabel()
        view.textColor = .galleryGrey
        view.font = R.font.robotoRegular(size: 16)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true

        return view
    }()
    
    lazy var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = .galleryMain
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        configureLayout()
        setupLayot()
        setupCollectionView()
        setupCollectionViewLayout()
        presenter?.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupRightNavBarButton()
        setupNavigationBar(isHidden: false)
        updateCollectionView()
        presenter?.viewIsReady()
    }
    
    @objc
    func onSettingsButtonTap() {
        presenter?.openSettings()
    }
    
    @objc
    func onCancelButtonTap() {
        presenter?.openTabBarViewController(index: 0)
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubviews(stackView, underLine, collectionView)
        infoStackView.addArrangedSubviews(userNameLabel, birthdayLabel)
        stackView.addArrangedSubviews(userPhotoImageView, infoStackView)
    }
    
    private func configureLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.height.equalTo(130)
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        userPhotoImageView.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(80)
        }

        infoStackView.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.height.equalTo(24)
        }
        
        birthdayLabel.snp.makeConstraints {
            $0.height.equalTo(22)
        }
        
        underLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(stackView.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
        }
    }
    
    private func setupLayot() {
        view.backgroundColor = .white
        scrollView.delegate = self
    }
    
    private func setupCollectionView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: profileCellId)
        collectionView.register(MainCollectionViewCell.self,
                                forCellWithReuseIdentifier: userImagesID)
    }
    
    private func setupCollectionViewLayout() {
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(stackView.snp.bottom).offset(26)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupRightNavBarButton() {
        let rightButton = UIBarButtonItem(image: R.image.settings(),
                                          style: .plain,
                                          target: self,
                                          action: #selector(onSettingsButtonTap))
        rightButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func openAddView(index: Int) {
//        let image = presenter?.getItem(index: index)
//        ImageObjectModel(imageData: )
//        let vc = AddDataConfigurator.getViewController(imageObject: image.)
//        self.navigationController?.pushViewController(vc,
//                                                      animated: true)
    }
}

extension ProfileViewController: ProfileVCProtocol {
    
    func setupView(userName: String,
                   birthday: String) {
        userNameLabel.text = userName
        birthdayLabel.text = birthday
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
    }
}
