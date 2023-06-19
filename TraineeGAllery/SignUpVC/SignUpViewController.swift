//
//  SignInViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation
import UIKit
import SnapKit

protocol SignUpViewProtocol: AnyObject, AlertMessageProtocol {
    
    
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
        view.setupBorder(color: .galleryGrey, borderWidth: 1, cornerRadius: 4)
        view.autocapitalizationType = .none
        let attributedString = "User Name *"
        view.attributedPlaceholder = attributedString.placeholderText(fontSize: 16, fontColor: .galleryMain)
        view.setupIcon(name: "user")
        view.setupTextFieldHeight(height: 40)
        
        return view
    }()
    
    lazy var birthdayTextField: CustomTextField = {
        let view = CustomTextField()
        view.setupBorder(color: .galleryGrey, borderWidth: 1, cornerRadius: 4)
        view.placeholder = "Birthday"
        view.keyboardType = .decimalPad
        view.setupIcon(name: "birthday")
        view.setupTextFieldHeight(height: 40)
        
        return view
    }()
    
    lazy var emailTextField: CustomTextField = {
        let view = CustomTextField()
        view.setupBorder(color: .galleryGrey, borderWidth: 1, cornerRadius: 4)
        view.keyboardType = .emailAddress
        view.addSubview(emailErrorLabel)
        view.addTarget(self, action: #selector(emailTextFieldChanging), for: .editingChanged)
        view.autocapitalizationType = .none
        let attributedString = "Email *"
        view.attributedPlaceholder = attributedString.placeholderText(fontSize: 16, fontColor: .galleryMain)
        view.setupTextFieldHeight(height: 40)
        
        return view
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let view = CustomTextField()
        view.setupBorder(color: .galleryGrey, borderWidth: 1, cornerRadius: 4)
        view.addSubview(passwordErrorLabel)
        view.addTarget(self, action: #selector(passwordTextFieldChanging), for: .editingChanged)
        let attributedString = "Password *"
        view.attributedPlaceholder = attributedString.placeholderText(fontSize: 16, fontColor: .galleryMain)
        view.textContentType = .oneTimeCode
        view.isSecureTextEntry = true
        view.addButton(button: eyeButton)
        view.setupTextFieldHeight(height: 40)
        
        return view
    }()
    
    lazy var confirmPasswordTextField: CustomTextField = {
        let view = CustomTextField()
        view.setupBorder(color: .galleryGrey, borderWidth: 1, cornerRadius: 4)
        view.setupTextFieldHeight(height: 40)
        let attributedString = "Confirm password *"
        view.attributedPlaceholder = attributedString.placeholderText(fontSize: 16, fontColor: .galleryMain)
        view.textContentType = .oneTimeCode
        view.addSubview(matchPasswordsLabel)
        view.addTarget(self, action: #selector(passwordsMatching), for: .editingChanged)
        view.isSecureTextEntry = true
        view.addButton(button: confirmEyeButton)
        
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
        view.setupButtonHeight(height: 40)
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
        view.setupButtonHeight(height: 40)
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
    
    lazy var emailErrorLabel: UILabel = {
        let view = UILabel()
        view.text = "Invalid e-mail adress"
        view.font = .robotoRegular(ofSize: 12)
        view.textColor = .galleryErrorRed
        view.isHidden = true
        
        return view
    }()
    
    lazy var passwordErrorLabel: UILabel = {
        let view = UILabel()
        view.text = "Invalid password. 1 uppercase, 1 lowercase letter, 1 number"
        view.font = .robotoRegular(ofSize: 12)
        view.textColor = .galleryErrorRed
        view.isHidden = true
        
        return view
    }()
    
    lazy var matchPasswordsLabel: UILabel = {
        let view = UILabel()
        view.text = "Passwords don't match"
        view.font = .robotoRegular(ofSize: 12)
        view.textColor = .galleryErrorRed
        view.isHidden = true
        
        return view
    }()
    
    lazy var emailImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "email")
        
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
    
    private func setupView() {
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
        
        emailTextField.addSubview(emailImageView)
        
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
        
        emailImageView.snp.makeConstraints {
            $0.centerY.equalTo(emailTextField.snp.centerY)
            $0.trailing.equalTo(emailTextField.snp.trailing).inset(11)
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
        guard let emailText = emailTextField.text else { return }

        if emailText.isEmailValid && arePaswordsEqual() {
            presenter?.registerNewUser(email: emailTextField.text ?? "",
                                       phone: "",
                                       fullName: userNameTextField.text ?? "",
                                       password: confirmPasswordTextField.text ?? "",
                                       username: userNameTextField.text ?? "",
                                       birthday: birthdayTextField.text ?? "",
                                       roles: [])
        } else {
            setAlertController(title: "Invalid output",
                               message: "Please, check the entered data")
        }
    }
    
    @objc
    func eyeButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        changeEyeButtonImage()
    }
    
    @objc
    func confirmEyeButtonTapped() {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        changeConfirmEyeButtonImage()
    }
    
    private func arePaswordsEqual() -> Bool {
        passwordTextField.text == confirmPasswordTextField.text
    }
    
    @objc
    func emailTextFieldChanging() {
        guard let emailText = emailTextField.text else { return }
 
        if !emailText.isEmpty {
            emailErrorLabel.isHidden = emailText.isEmailValid ? true : false
            emailTextField.layer.borderColor = emailText.isEmailValid ? .galleryGrey : UIColor.red.cgColor
            emailImageView.image = emailText.isEmailValid ? (UIImage(named: "email")) : (UIImage(named: "warning"))
        } else {
            emailErrorLabel.isHidden = true
            emailTextField.layer.borderColor = .galleryGrey
            emailImageView.image = UIImage(named: "email")
        }
    }
    
    @objc
    func passwordTextFieldChanging() {
        guard let passwordText = passwordTextField.text else { return }
        
        changeEyeButtonImage()
        if !passwordText.isEmpty {
            passwordErrorLabel.isHidden = passwordText.isPasswordValid ? true : false
            passwordTextField.layer.borderColor = passwordText.isPasswordValid ? .galleryGrey : UIColor.red.cgColor
        } else {
            passwordErrorLabel.isHidden = true
            passwordTextField.layer.borderColor = .galleryGrey
        }
    }
    
    @objc
    func passwordsMatching() {
        guard let passwordText = confirmPasswordTextField.text else { return }
        
        changeConfirmEyeButtonImage()
        if !passwordText.isEmpty {
            matchPasswordsLabel.isHidden = arePaswordsEqual() ? true : false
            confirmPasswordTextField.layer.borderColor = arePaswordsEqual() ? .galleryGrey : UIColor.red.cgColor
        } else {
            matchPasswordsLabel.isHidden = true
            confirmPasswordTextField.layer.borderColor = .galleryGrey
        }
    }
    
    private func changeConfirmEyeButtonImage() {
        if arePaswordsEqual() || confirmPasswordTextField.text!.isEmpty {
            if confirmPasswordTextField.isSecureTextEntry {
                confirmEyeButton.setImage(UIImage(named: "passwordOff"), for: .normal)
            } else {
                confirmEyeButton.setImage(UIImage(named: "password"), for: .normal)
            }
        } else {
            confirmEyeButton.setImage(UIImage(named: "warning"), for: .normal)
            confirmEyeButton.setImage(UIImage(named: "warning"), for: .selected)
        }
    }
    
    private func changeEyeButtonImage() {
        guard let passwordText = passwordTextField.text else { return }

        if passwordText.isPasswordValid || passwordText.isEmpty {
            if passwordTextField.isSecureTextEntry {
                eyeButton.setImage(UIImage(named: "passwordOff"), for: .normal)
            } else {
                eyeButton.setImage(UIImage(named: "password"), for: .normal)
            }
        } else {
            eyeButton.setImage(UIImage(named: "warning"), for: .normal)
            eyeButton.setImage(UIImage(named: "warning"), for: .selected)
        }
    }
}

extension SignUpViewController: SignUpViewProtocol {
    
    
}

