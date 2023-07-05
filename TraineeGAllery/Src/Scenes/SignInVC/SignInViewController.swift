//
//  SignInViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.04.23.
//

import Foundation
import UIKit
import SnapKit

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
        view.textAlignment = .center
        view.text = R.string.localization.signInTitle()
        view.font = R.font.robotoBold(size: 30)
        view.addUnderLine()
        
        return view
    }()
    
    lazy var emailTextField: CustomTextField = {
        let view = CustomTextField()
        view.placeholder = R.string.localization.email()
        view.autocapitalizationType = .none
        view.setupBorder()
        view.setupTextFieldHeight(height: 40)
        view.setupIconOnTextField(image: R.image.email())

        return view
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let view = CustomTextField()
        view.placeholder = R.string.localization.passwordSignIn()
        view.setupBorder()
        view.setupTextFieldHeight(height: 40)
        view.addButton(button: eyeButton)
        view.isSecureTextEntry = true

        return view
    }()
    
    lazy var eyeButton: UIButton = {
        let view = UIButton()
        view.setImage(R.image.passwordOff(),
                      for: .normal)
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
        view.setTitle(R.string.localization.signInTitle(),
                      for: .normal)
        view.titleLabel?.font = R.font.robotoMedium(size: 16)
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
        view.setTitle(R.string.localization.signUpTitle(),
                      for: .normal)
        view.setTitleColor(.black,
                           for: .normal)
        view.titleLabel?.font = R.font.robotoMedium(size: 16)
        view.backgroundColor = .white
        view.setupButtonHeight(height: 40)

        return view
    }()
    
    lazy var leftBarButton: UIButton = {
        let view = UIButton.leftBarBut(title: R.string.localization.cancelTitle())
        view.addTarget(self,
                       action: #selector(popViewController),
                       for: .touchUpInside)

        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkOrientationAndSetLayout()
        setupNavigationBar(isHidden: false,
                           customBackButton: UIBarButtonItem(customView: leftBarButton))
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        checkOrientationAndSetLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupStackViews()
        configureLayout()
        checkOrientationAndSetLayout()
    }
    
    @objc
    func eyeButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
            eyeButton.setImage(R.image.passwordOff(), for: .normal)
        } else {
            eyeButton.setImage(R.image.password(), for: .normal)
        }
    }
    
    @objc
    func popViewController() {
        presenter?.popViewController(viewController: self)
    }
    
    @objc
    func signInButtonTap() {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            if !email.isEmpty && !password.isEmpty {
                presenter?.signInButtonTap(userName: email, password: password)
            } else {
                print(R.string.localization.emptyFields())
            }
        }
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
        scrollView.delegate = self
    }
    
    func setupStackViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(signInTitle, textFieldsStackView, buttonsStackView)
        stackView.setCustomSpacing(55, after: signInTitle)
        stackView.setCustomSpacing(60, after: textFieldsStackView)
        textFieldsStackView.addArrangedSubviews(emailTextField, passwordTextField)
        textFieldsStackView.setCustomSpacing(20, after: emailTextField)
        buttonsStackView.addArrangedSubviews(signInButton, signUpButton)
        buttonsStackView.setCustomSpacing(10, after: signInButton)
    }
    
    func configureLayout() {
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
}

extension SignInViewController: SignInViewProtocol { }
