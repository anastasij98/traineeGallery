//
//  ProfileViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit
import SnapKit

protocol ProfileVCProtocol: AnyObject {
    
    /// Установка view ViewControler'a
    /// - Parameters:
    ///   - userName: имя пользователя
    ///   - birthday: дата рождения пользователя 
    func setupView(userName: String,
                   birthday: String) 
}

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    var presenter: ProfilePresenterProtocol?
    
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
        view.image = UIImage(named: "Logo-2")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.galleryGrey.cgColor

        return view
    }()
    
    lazy var userNameLabel: UILabel = {
        let view = UILabel()
        view.textColor = .galleryBlack
        view.font = .robotoRegular(ofSize: 18)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        
        return view
    }()
    
    lazy var birthdayLabel: UILabel = {
        let view = UILabel()
        view.textColor = .galleryGrey
        view.font = .robotoRegular(ofSize: 16)
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
        
        setupLayot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewIsReady()
        setupRightNavBarButton()
        setupNavigationBar(isHidden: false)
    }
    
    func setupLayot() {
        view.backgroundColor = .white
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubviews(stackView, underLine)
        infoStackView.addArrangedSubviews(userNameLabel, birthdayLabel)
        stackView.addArrangedSubviews(userPhotoImageView, infoStackView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        stackView.snp.makeConstraints {
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
    
    func setupRightNavBarButton() {
        let rightButton = UIBarButtonItem(image: UIImage(named: "settings"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(onSettingsButtonTap))
        rightButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc
    func onSettingsButtonTap() {
        presenter?.openSettings()
    }
    
    @objc
    func onCancelButtonTap() {
        presenter?.openTabBarViewController(index: 0)
    }
}

extension ProfileViewController: ProfileVCProtocol {
    
    func setupView(userName: String,
                   birthday: String) {
        userNameLabel.text = userName
        birthdayLabel.text = birthday
    }
}
