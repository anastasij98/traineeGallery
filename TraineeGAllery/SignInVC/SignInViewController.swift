//
//  SignInViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.04.23.
//

import Foundation
import UIKit
import SnapKit

protocol SignInViewProtocol: AnyObject {
    
    
}

class SignInViewController: UIViewController {
    
    var presenter: SignInPresenterProtocol?
    
    lazy var textFieldsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        
        return view
    }()
    
    lazy var signInTitle: UILabel = {
        let view = UILabel()
        view.text = "Sign In"
        view.textAlignment = .center
        view.font = .robotoBold(ofSize: 30)
        
        return view
    }()
    
    lazy var titleUnderline: UIView = {
        let view = UIView()
        view.backgroundColor = .customPink
        
        return view
    }()
    
    lazy var emailField: CustomTextField = {
        let view = CustomTextField()
        view.layer.borderColor = .mainGrey
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        view.placeholder = "Email"
//        view.setRightImage(imageName: "email")
        
        return view
    }()

    lazy var passwordField: CustomTextField = {
        let view = CustomTextField()
        view.layer.borderColor = .mainGrey
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        view.placeholder = "Password"

        return view
    }()
    
    lazy var emailImageView = UIImageView(image: UIImage(named: "email"))
    lazy var passwordImageView = UIImageView(image: UIImage(named: "password"))
    
    lazy var forgotButton: UIButton = {
        let view = UIButton()
        view.setTitle("Forgot login or password?",
                      for: .normal)
        view.setTitleColor(.mainGrey,
                           for: .normal)
        view.titleLabel?.font = .robotoRegular(ofSize: 13)
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        
        return view
    }()
    
    lazy var signInButton: UIButton = {
        let view = UIButton()
        view.setTitle("Sign In",
                      for: .normal)
        view.titleLabel?.font = .robotoBold(ofSize: 17)
        view.backgroundColor = .customBlack
        view.layer.cornerRadius = 4
        view.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.width.equalTo(120)
        }
        view.addTarget(self,
                       action: #selector(openGallery),
                       for: .touchUpInside)
        
        return view
    }()
    
    lazy var signUpButton: UIButton = {
        let view = UIButton()
        view.setTitle("Sign Up",
                      for: .normal)
        view.setTitleColor(.black,
                           for: .normal)
        view.titleLabel?.font = .robotoRegular(ofSize: 17)
        view.backgroundColor = .white
        view.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.width.equalTo(103)
        }
        
        return view
    }()
    
    override func viewDidLoad() {        
        view.backgroundColor = .white
        setupView()

    }
    
    func setupView() {
        view.addSubviews(signInTitle, textFieldsStackView, forgotButton, buttonsStackView)
        textFieldsStackView.addArrangedSubviews(emailField, passwordField)
        signInTitle.addSubview(titleUnderline)
        textFieldsStackView.setCustomSpacing(29, after: emailField)
        
        buttonsStackView.addArrangedSubviews(signInButton, signUpButton)
        buttonsStackView.setCustomSpacing(19, after: signInButton)

        emailField.addSubview(emailImageView)
        passwordField.addSubview(passwordImageView)

        signInTitle.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(188)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(30)
            $0.width.equalTo(94)
        }
        
        titleUnderline.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.width.equalTo(signInTitle.snp.width)
            $0.top.equalTo(signInTitle.snp.bottom)
            $0.centerX.equalTo(signInTitle.snp.centerX)
        }
        
        textFieldsStackView.snp.makeConstraints {
            $0.top.equalTo(signInTitle.snp.bottom).offset(57)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
        }
        
        emailImageView.snp.makeConstraints {
            $0.centerY.equalTo(emailField.snp.centerY)
            $0.trailing.equalTo(emailField.snp.trailing).inset(11)
        }
        passwordImageView.snp.makeConstraints {
            $0.centerY.equalTo(passwordField.snp.centerY)
            $0.trailing.equalTo(passwordField.snp.trailing).inset(11)
        }
        
        forgotButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.top.equalTo(passwordField.snp.bottom).offset(10)
        }
        
        buttonsStackView.snp.makeConstraints {
            $0.top.equalTo(forgotButton.snp.bottom).offset(50)
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    @objc
    func openGallery() {
        presenter?.openGallery()
    }
}

extension SignInViewController: SignInViewProtocol {
    
}
