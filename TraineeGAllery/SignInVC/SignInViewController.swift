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
        view.backgroundColor = .galleryMain
        
        return view
    }()
    
    lazy var emailTextField: CustomTextField = {
        let view = CustomTextField()
        view.placeholder = "Email"
        view.autocapitalizationType = .none
        view.setupBorder(color: .galleryGrey, borderWidth: 1, cornerRadius: 4)
        view.setupTextFieldHeight(height: 40)
        view.setupIcon(name: "email")
        
        return view
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let view = CustomTextField()
        view.placeholder = "Password"
        view.setupBorder(color: .galleryGrey, borderWidth: 1, cornerRadius: 4)
        view.setupTextFieldHeight(height: 40)
        view.addButton(button: eyeButton)
        view.isSecureTextEntry = true

        return view
    }()
    
    lazy var eyeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "passwordOff"), for: .normal)
        view.addTarget(self,
                       action: #selector(eyeButtonTapped),
                       for: .touchUpInside)

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
        view.titleLabel?.font = .robotoMedium(ofSize: 16)
        view.backgroundColor = .galleryBlack
        view.layer.cornerRadius = 10
        view.addTarget(self,
                       action: #selector(signInButtonTap),
                       for: .touchUpInside)
        view.setupButtonHeight(height: 40)

        return view
    }()
    
    lazy var signUpButton: UIButton = {
        let view = UIButton()
        view.setTitle("Sign Up",
                      for: .normal)
        view.setTitleColor(.black,
                           for: .normal)
        view.titleLabel?.font = .robotoMedium(ofSize: 16)
        view.backgroundColor = .white
        view.setupButtonHeight(height: 40)

        return view
    }()
    
    lazy var leftBarButton: UIButton = {
        let view = UIButton.leftBarBut(title: "Cancel")
        view.addTarget(self,
                       action: #selector(popViewController),
                       for: .touchUpInside)

        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkOrientationAndSetLayout()
        setupNavigationBar(isHidden: false, customBackButton: UIBarButtonItem(customView: leftBarButton))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        checkOrientationAndSetLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        checkOrientationAndSetLayout()
    }
    
    @objc
    func eyeButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
            eyeButton.setImage(UIImage(named: "passwordOff"), for: .normal)
        } else {
            eyeButton.setImage(UIImage(named: "password"), for: .normal)            
        }
    }
    
    @objc
    func popViewController() {
        presenter?.popViewController(viewController: self)
    }
    
    func checkOrientationAndSetLayout() {
        if UIDevice.current.orientation.isLandscape {
            stackView.snp.remakeConstraints {
                $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(50)
                $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom).inset(10)
            }
        } else {
            stackView.snp.remakeConstraints {
                $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(120)
            }
        }
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(signInTitle, textFieldsStackView, buttonsStackView)
        stackView.setCustomSpacing(55, after: signInTitle)
        stackView.setCustomSpacing(60, after: textFieldsStackView)
        textFieldsStackView.addArrangedSubviews(emailTextField, passwordTextField)
        signInTitle.addSubview(titleUnderline)
        textFieldsStackView.setCustomSpacing(20, after: emailTextField)
        
        buttonsStackView.addArrangedSubviews(signInButton, signUpButton)
        buttonsStackView.setCustomSpacing(10, after: signInButton)
        
        scrollView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(120)
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
        
        signInButton.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(106)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(106)
        }
        
        signUpButton.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(106)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(106)
        }
    }
    
    @objc
    func signInButtonTap() {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            if !email.isEmpty && !password.isEmpty {
                presenter?.signInButtonTap(userName: email, password: password)
            } else {
                print("Fields are empty")
            }
        }
    }
}

extension SignInViewController: SignInViewProtocol {
    
    
}
