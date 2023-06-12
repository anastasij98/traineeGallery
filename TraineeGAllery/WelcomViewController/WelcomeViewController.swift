//
//  WelcomeViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 17.04.23.
//

import Foundation
import UIKit
import SnapKit

protocol WelcomeViewControllerProtocol: AnyObject {
    
}

class WelcomeViewController: UIViewController {
    
    var presenter: WelcomePresenterProtocol?
    
    lazy var welcomeStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        
        return view
    }()
    
    lazy var welcomeImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Intersect 1")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var welcomeLabel: UILabel = {
        let view = UILabel()
        view.text = "Welcome to Gallery!"
        view.textAlignment = .center
        view.tintColor = .black
        view.font = .robotoBold(ofSize: 30)
        
        return view
    }()
    
    lazy var createAccountButton: UIButton = {
        let view = UIButton()
        view.setTitle("Create an account", for: .normal)
        view.titleLabel?.font = .robotoMedium(ofSize: 16)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .galleryBlack
        view.layer.cornerRadius = 10
        view.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        view.addTarget(self,
                       action: #selector(onSignUpButtonTap),
                       for: .touchUpInside)
        
        return view
    }()
    
    lazy var haveAccountButton: UIButton = {
        let view = UIButton()
        view.setTitle("I already have an account", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = .robotoMedium(ofSize: 16)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        view.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        view.addTarget(self,
                       action: #selector(onSignInButtonTap),
                       for: .touchUpInside)
        
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(isHidden: true)
    }
    
    func setupStackView() {
        view.backgroundColor = .white
        view.addSubview(welcomeStackView)
        welcomeStackView.addArrangedSubviews(welcomeImageView, welcomeLabel, createAccountButton, haveAccountButton)
        welcomeStackView.setCustomSpacing(36, after: welcomeImageView)
        welcomeStackView.setCustomSpacing(80, after: welcomeLabel)
        welcomeStackView.setCustomSpacing(20, after: createAccountButton)
        
        welcomeStackView.snp.makeConstraints {
            $0.centerY.equalTo(view.snp.centerY)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
        }
    }
    
    @objc
    func onSignUpButtonTap() {
        presenter?.onSignUpButtonTap()
    }
    
    @objc
    func onSignInButtonTap() {
        presenter?.onSignInButtonTap()
    }
}

extension WelcomeViewController: WelcomeViewControllerProtocol {
    
    
}
