//
//  SignInViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation
import UIKit
import SnapKit

protocol SignUpViewProtocol: AnyObject {
    
    
}

class SignUpViewController: UIViewController, UIScrollViewDelegate {
    
    var presenter: SignUpPresenterProtocol?
    
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
    
    lazy var textFieldStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        
        return view
    }()
    
    lazy var signUpTitle: UILabel = {
        let view = UILabel()
        view.text = "Sign Up"
        view.textAlignment = .center
        view.font = .robotoBold(ofSize: 30)
        view.textColor = .galleryBlack
        
        return view
    }()
    
    lazy var titleUnderline: UIView = {
        let view = UIView()
        view.backgroundColor = .galleryMain
        
        return view
    }()
    
    lazy var userNameTextField: CustomTextField = {
        let view = CustomTextField()
        view.layer.borderColor = .mainGrey
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        let placeholderText = NSMutableAttributedString(string: "User Name *")
        placeholderText.addAttribute(.font,
                                    value: UIFont.robotoRegular(ofSize: 16),
                                    range: NSRange(location: 0, length: placeholderText.length))
        placeholderText.addAttribute(NSAttributedString.Key.foregroundColor,
                                    value: UIColor.galleryMain,
                                    range: NSRange(location: placeholderText.length - 1, length: 1))
        view.attributedPlaceholder = placeholderText
        view.setupIcon(name: "user")

        return view
    }()
    
    lazy var birthdayTextField: CustomTextField = {
        let view = CustomTextField()
        view.layer.borderColor = .mainGrey
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        view.placeholder = "Birthday"
        view.keyboardType = .numbersAndPunctuation
        view.setupIcon(name: "birthday")

        return view
    }()
    
    lazy var emailTextField: CustomTextField = {
        let view = CustomTextField()
        view.layer.borderColor = .mainGrey
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        let placeholderText = NSMutableAttributedString(string: "Email *")
        placeholderText.addAttribute(.font,
                                    value: UIFont.robotoRegular(ofSize: 16),
                                    range: NSRange(location: 0, length: placeholderText.length))
        placeholderText.addAttribute(NSAttributedString.Key.foregroundColor,
                                    value: UIColor.galleryMain,
                                    range: NSRange(location: placeholderText.length - 1, length: 1))
        view.attributedPlaceholder = placeholderText
        view.keyboardType = .emailAddress
        view.setupIcon(name: "email")
        view.addSubview(emailErrorLabel)
        view.addTarget(self, action: #selector(emailTextFieldChanging), for: .editingChanged)

        return view
    }()

    lazy var passwordTextField: CustomTextField = {
        let view = CustomTextField()
        view.layer.borderColor = .mainGrey
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        let placeholderText = NSMutableAttributedString(string: "Password *")
        placeholderText.addAttribute(.font,
                                    value: UIFont.robotoRegular(ofSize: 16),
                                    range: NSRange(location: 0, length: placeholderText.length))
        placeholderText.addAttribute(NSAttributedString.Key.foregroundColor,
                                    value: UIColor.galleryMain,
                                    range: NSRange(location: placeholderText.length - 1, length: 1))
        view.attributedPlaceholder = placeholderText
        view.isSecureTextEntry = true
        view.addButton(button: eyeButton)
        view.addSubview(passwordErrorLabel)
        view.addTarget(self, action: #selector(passwordTextFieldChanging), for: .editingChanged)

        return view
    }()
    
    lazy var confirmPasswordTextField: CustomTextField = {
        let view = CustomTextField()
        view.layer.borderColor = .mainGrey
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        let placeholderText = NSMutableAttributedString(string: "Confirm password *")
        placeholderText.addAttribute(.font,
                                    value: UIFont.robotoRegular(ofSize: 16),
                                    range: NSRange(location: 0, length: placeholderText.length))
        placeholderText.addAttribute(NSAttributedString.Key.foregroundColor,
                                    value: UIColor.galleryMain,
                                    range: NSRange(location: placeholderText.length - 1, length: 1))
        view.attributedPlaceholder = placeholderText
        view.isSecureTextEntry = true
        view.addButton(button: confirmEyeButton)
        view.addSubview(matchPasswordsLabel)
        view.addTarget(self, action: #selector(passwordsMatching), for: .editingChanged)

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
    
    lazy var confirmEyeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "passwordOff"), for: .normal)
        view.addTarget(self,
                       action: #selector(confirmEyeButtonTapped),
                       for: .touchUpInside)
        
        return view
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        
        return view
    }()
    
    lazy var signUpButton: UIButton = {
        let view = UIButton()
        view.setTitle("Sign Up",
                      for: .normal)
        view.titleLabel?.font = .robotoBold(ofSize: 17)
        view.backgroundColor = .galleryBlack
        view.layer.cornerRadius = 10
        view.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        view.addTarget(self,
                       action: #selector(onSignUpButtonTap),
                       for: .touchUpInside)
        
        return view
    }()
    
    lazy var signInButton: UIButton = {
        let view = UIButton()
        view.setTitle("Sign In",
                      for: .normal)
        view.setTitleColor(.black,
                           for: .normal)
        view.titleLabel?.font = .robotoRegular(ofSize: 17)
        view.backgroundColor = .white
        view.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        view.addTarget(self,
                       action: #selector(onSignInButtonTap),
                       for: .touchUpInside)
        
        return view
    }()
    
    lazy var leftBarButton: UIButton = {
        let view = UIButton.leftBarBut(title: "Cancel")
        view.addTarget(self,
                       action: #selector(popViewController),
                       for: .touchUpInside)

        return view
    }()
    
    var emailErrorLabel: UILabel = {
       let view = UILabel()
        view.text = "Invalid e-mail adress"
        view.font = .robotoRegular(ofSize: 12)
        view.textColor = .galleryErrorRed
        view.isHidden = true
        
       return view
    }()
    
    var passwordErrorLabel: UILabel = {
       let view = UILabel()
        view.text = "Invalid password. 1 uppercase, 1 lowercase letter, 1 number"
        view.font = .robotoRegular(ofSize: 12)
        view.numberOfLines = 0
        view.textColor = .galleryErrorRed
        view.isHidden = true
        
       return view
    }()
    
    var matchPasswordsLabel: UILabel = {
       let view = UILabel()
        view.text = "Passwords don't match"
        view.font = .robotoRegular(ofSize: 12)
        view.textColor = .galleryErrorRed
        view.isHidden = true
        
       return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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

    func checkOrientationAndSetLayout() {
        if UIDevice.current.orientation.isLandscape {
            stackView.snp.remakeConstraints {
                $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(50)
                $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom).inset(10)
            }
        } else {
            stackView.snp.remakeConstraints {
                $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(70)
            }
        }
    }
    
    func setupView() {
        view.backgroundColor = .white
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(signUpTitle, textFieldStackView, buttonsStackView)
        stackView.setCustomSpacing(55, after: signUpTitle)
        stackView.setCustomSpacing(60, after: textFieldStackView)

        signUpTitle.addSubview(titleUnderline)
        
        textFieldStackView.addArrangedSubviews(userNameTextField, birthdayTextField, emailTextField,  passwordTextField, confirmPasswordTextField)

        setupTextFieldsSpacing()
        
        buttonsStackView.addArrangedSubviews(signUpButton, signInButton)
        buttonsStackView.setCustomSpacing(10, after: signUpButton)

        scrollView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(70)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
        }

        titleUnderline.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.width.equalTo(signUpTitle.snp.width)
            $0.bottom.equalTo(signUpTitle.snp.bottom).offset(5)
            $0.centerX.equalTo(signUpTitle.snp.centerX)
        }
        
        textFieldStackView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
        }
        
        buttonsStackView.snp.makeConstraints {
            $0.top.equalTo(textFieldStackView.snp.bottom).offset(50)
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        signInButton.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(106)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(106)
        }
        
        signUpButton.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(106)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(106)
        }
        
        emailErrorLabel.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.top.equalTo(emailTextField.snp.bottom).offset(5)
            $0.height.equalTo(10)
        }
        
        passwordErrorLabel.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(5)
            $0.height.equalTo(10)
        }
        
        matchPasswordsLabel.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(5)
            $0.height.equalTo(10)
        }
    }
    
    func setupTextFieldsSpacing() {
        let array = [userNameTextField, birthdayTextField, emailTextField, passwordTextField, confirmPasswordTextField]
        array.forEach { textField in
            textFieldStackView.setCustomSpacing(20, after: textField)
        }
    }
    
    @objc
    func popViewController() {
        presenter?.popViewController(viewController: self)
    }
    
    @objc
    func onSignInButtonTap() {
        presenter?.onSignInButtonTap()
    }
    
    @objc
    func onSignUpButtonTap() {
        presenter?.registerNewUser(email: emailTextField.text ?? "",
                                   phone: "",
                                   fullName: userNameTextField.text ?? "",
                                   password: confirmPasswordTextField.text ?? "",
                                   username: userNameTextField.text ?? "",
                                   birthday: birthdayTextField.text ?? "",
                                   roles: [])
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
    func confirmEyeButtonTapped() {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        if arePaswordsEqual() {
            if confirmPasswordTextField.isSecureTextEntry {
                confirmEyeButton.setImage(UIImage(named: "passwordOff"), for: .normal)
            } else {
                confirmEyeButton.setImage(UIImage(named: "password"), for: .normal)
            }
        } else {
            confirmEyeButton.setImage(UIImage(named: "warning"), for: .normal)
        }
    }
    
    func arePaswordsEqual() -> Bool {
        passwordTextField.text == confirmPasswordTextField.text
    }
    
    @objc
    func emailTextFieldChanging() {
        if !emailTextField.text!.isEmpty {
            emailErrorLabel.isHidden = emailTextField.text!.isEmailValid ? true : false
            emailTextField.layer.borderColor = emailTextField.text!.isEmailValid ? .mainGrey : UIColor.red.cgColor
        } else {
            emailErrorLabel.isHidden = true
            emailTextField.layer.borderColor = .mainGrey
        }
    }
    
    @objc
    func passwordTextFieldChanging() {
        if !passwordTextField.text!.isEmpty {
            passwordErrorLabel.isHidden = passwordTextField.text!.isPasswordValid ? true : false
            passwordTextField.layer.borderColor = passwordTextField.text!.isPasswordValid ? .mainGrey : UIColor.red.cgColor
        } else {
            passwordErrorLabel.isHidden = true
            passwordTextField.layer.borderColor = .mainGrey
        }
    }
    
    @objc
    func passwordsMatching() {
        if !confirmPasswordTextField.text!.isEmpty {
            matchPasswordsLabel.isHidden = arePaswordsEqual() ? true : false
            confirmPasswordTextField.layer.borderColor = arePaswordsEqual() ? .mainGrey : UIColor.red.cgColor
            confirmEyeButton.setImage(UIImage(named: "warning"), for: .normal)
        } else {
            matchPasswordsLabel.isHidden = true
            confirmPasswordTextField.layer.borderColor = .mainGrey
            if confirmPasswordTextField.isSecureTextEntry {
                confirmEyeButton.setImage(UIImage(named: "passwordOff"), for: .normal)
                
            } else {
                confirmEyeButton.setImage(UIImage(named: "password"), for: .normal)
                
            }
        }
    }
}

extension SignUpViewController: SignUpViewProtocol {
    
    
}
