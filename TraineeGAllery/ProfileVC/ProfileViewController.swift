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
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        
        return view
    }()
    
    var userPhotoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.image = UIImage(named: "userCamera")
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.mainGrey.cgColor

        return view
    }()
    
    lazy var userNameLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .robotoRegular(ofSize: 17)
        view.text = "User Name"
        
        return view
    }()
    
    lazy var birthdayLabel: UILabel = {
        let view = UILabel()
        view.textColor = .mainGrey
        view.font = .robotoRegular(ofSize: 12)
        view.text = "20.01.2000"
        
        return view
    }()
    
    lazy var viewsLabel: UILabel = {
        let view = UILabel()
        view.font = .robotoRegular(ofSize: 12)
        let string = NSMutableAttributedString(string: "Views: ")
        string.addAttribute(NSAttributedString.Key.foregroundColor,
                          value: UIColor.black,
                          range: NSRange(location: 0, length: 5))
        string.addAttribute(NSAttributedString.Key.foregroundColor,
                          value: UIColor.mainGrey,
                          range: NSRange(location: 6, length: string.length - 6))
        view.attributedText = string
        
        return view
    }()
    
    lazy var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGrey
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupLayot()
        navigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavgationBar()
    }
    
    func setupLayot() {
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(userPhotoImageView, userNameLabel, birthdayLabel, viewsLabel)
        stackView.setCustomSpacing(10, after: userPhotoImageView)
        stackView.setCustomSpacing(8, after: userNameLabel)
        stackView.setCustomSpacing(27, after: birthdayLabel)
        
        viewsLabel.addSubview(underLine)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
        }
        
        userPhotoImageView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.width.equalTo(100)
            $0.centerX.equalTo(stackView.snp.centerX)
            $0.top.equalTo(stackView.snp.top).offset(21)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.height.equalTo(17)
            $0.width.equalTo(85)
            $0.centerX.equalTo(stackView.snp.centerX)
        }
        
        birthdayLabel.snp.makeConstraints {
            $0.height.equalTo(12)
            $0.width.equalTo(61)
            $0.centerX.equalTo(stackView.snp.centerX)
        }
        
        viewsLabel.snp.makeConstraints {
            $0.height.equalTo(12)
            $0.width.equalTo(66)
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading).offset(16)
        }
        
        underLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(viewsLabel.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
    }
    
    func navigationBar() {
        let rightButton = UIBarButtonItem(image: UIImage(named: "settings"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(settings))
        rightButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightButton
        
        let leftButton = UIBarButtonItem(title: "Cancel",
                                         style: .plain,
                                         target: self,
                                         action: #selector(onCancelButtonTap))
        leftButton.tintColor = .customDarkGrey
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func setupNavgationBar() {
//        if let appearance = navigationController?.navigationBar.standardAppearance {
//            appearance.configureWithTransparentBackground()
//            let color: UIColor = .black
//            appearance.shadowColor = color
////            appearance.shadowImage = color.image()
//            //априенс бэкБатон как и аринес навБара
////            appearance.backButtonAppearance
//            navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        }


//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.navigationBar.backIndicatorImage = nil
//        navigationController?.navigationBar.backIndicatorTransitionMaskImage = nil
//        navigationController?.navigationBar.tintColor = .customDarkGrey
//        navigationItem.backBarButtonItem = .init(title: "Work",
//                                                         image: UIImage(named: "Vector"),
//                                                         target: nil,
//                                                         action: nil)
//
        let backItem = UIBarButtonItem(image: nil,
                                       style: .done,
                                       target: nil,
                                       action: nil)
      
        navigationItem.backBarButtonItem = backItem
        navigationController?.navigationBar.backItem?.backBarButtonItem = backItem

        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.navigationBar.backIndicatorImage = nil
//        navigationController?.navigationBar.backIndicatorTransitionMaskImage = nil
//        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "downArrow"),
//                                                               for: .top,
//                                                               barMetrics: .default)
//        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
//        navigationController?.navigationBar.tintColor = .customDarkGrey
//        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "downArrow"),
//                                                               for: .default)
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "downArrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "downArrow")

//        navigationItem.backButtonTitle = "lkjhgfd"
//        navigationItem.backAction?.image = UIImage(named: "downArrow")
//        navigationItem.backBarButtonItem?.image = UIImage(named: "downArrow")
//        navigationItem.backBarButtonItem?.setBackgroundImage(UIImage(named: "downArrow"),
//                                                             for: .normal,
//                                                             barMetrics: .default)
//        navigationItem.backBarButtonItem?.setBackButtonBackgroundImage(UIImage(named: "downArrow"),
//                                                                       for: .normal,
//                                                                       barMetrics: .default)
//        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "downArrow")
//        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "downArrow")
//
//        navigationController?.navigationBar.topItem?.backBarButtonItem?.image = UIImage(named: "downArrow")
        if let navigationController = navigationController {
            let appearance = navigationController.navigationBar.standardAppearance
                navigationController.underlineAppereance(appearance: appearance,
                                                         navController: navigationController,
                                                         color: .mainGrey)
        }
    }
    
    @objc
    func settings() {
        presenter?.openSettings()
    }
    
    @objc
    func onCancelButtonTap() {
        presenter?.openTabBarViewController(index: 0)
    }
}

extension UINavigationController {
    
    func underlineAppereance(appearance: UINavigationBarAppearance,
                             navController: UINavigationController,
                             color selectedColor: UIColor) {
        appearance.configureWithTransparentBackground()
            let color: UIColor = selectedColor
        appearance.shadowColor = color
//            appearance.shadowImage = color.image()
            //априенс бэкБатон как и аринес навБара
//            appearance.backButtonAppearance
            navController.navigationBar.scrollEdgeAppearance = appearance
        }
}

extension ProfileViewController: ProfileVCProtocol {
    
    
}
