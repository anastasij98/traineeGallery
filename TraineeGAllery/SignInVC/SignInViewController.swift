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

class SignInViewController: UIViewController, UIScrollViewDelegate {
    
    var presenter: SignInPresenterProtocol?
    
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
    
    lazy var emailTextField: CustomTextField = {
        let view = CustomTextField()
        view.layer.borderColor = .mainGrey
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        view.placeholder = "Email"
        
        return view
    }()

    lazy var passwordTextField: CustomTextField = {
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
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
        checkOrientationAndSetLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        checkOrientationAndSetLayout()
    }
    
    func checkOrientationAndSetLayout() {
        if UIDevice.current.orientation.isLandscape {
            stackView.snp.remakeConstraints {
                $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(50)
                $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom).inset(10)
            }
        } else {
            stackView.snp.remakeConstraints {
                $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(188)
            }
        }
    }

    func setupView() {
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(signInTitle, textFieldsStackView, forgotButton, buttonsStackView)
        stackView.setCustomSpacing(55, after: signInTitle)
        textFieldsStackView.addArrangedSubviews(emailTextField, passwordTextField)
        signInTitle.addSubview(titleUnderline)
        textFieldsStackView.setCustomSpacing(29, after: emailTextField)
        
        buttonsStackView.addArrangedSubviews(signInButton, signUpButton)
        buttonsStackView.setCustomSpacing(19, after: signInButton)

        emailTextField.addSubview(emailImageView)
        passwordTextField.addSubview(passwordImageView)

        scrollView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(188)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
        }
        
        titleUnderline.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.width.equalTo(signInTitle.snp.width)
            $0.bottom.equalTo(signInTitle.snp.bottom).offset(5)
            $0.centerX.equalTo(signInTitle.snp.centerX)
        }
        
        textFieldsStackView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
        }
        
        emailImageView.snp.makeConstraints {
            $0.centerY.equalTo(emailTextField.snp.centerY)
            $0.trailing.equalTo(emailTextField.snp.trailing).inset(11)
        }
        
        passwordImageView.snp.makeConstraints {
            $0.centerY.equalTo(passwordTextField.snp.centerY)
            $0.trailing.equalTo(passwordTextField.snp.trailing).inset(11)
        }
    }
    
    @objc
    func openGallery() {
        presenter?.openTabBar()
    }
}

extension SignInViewController: SignInViewProtocol {
    
    
}
