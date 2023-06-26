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
        view.textAlignment = .center
        view.text = R.string.localization.signUpTitle()
        view.font = R.font.robotoBold(size: 30)
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
        view.setupBorder()
        view.autocapitalizationType = .none
        view.addSubview(userNameErrorLabel)
        let attributedString = R.string.localization.attributedUserName()
        view.attributedPlaceholder = attributedString.placeholderText(fontSize: 16,
                                                                      fontColor: .galleryMain)
        view.addTarget(self,
                       action: #selector(userNameTextFieldChanging),
                       for: .editingChanged)
        view.setupTextFieldHeight(height: 40)
        
        return view
    }()
    
    lazy var birthdayTextField: CustomTextField = {
        let view = CustomTextField()
        view.setupBorder()
        view.addSubview(birthdayErrorLabel)
        view.placeholder = R.string.localization.birthday()
        view.keyboardType = .decimalPad
        view.addTarget(self,
                       action: #selector(birthdayTextFieldChanging),
                       for: .editingChanged)
        view.setupTextFieldHeight(height: 40)
        
        return view
    }()
    
    lazy var emailTextField: CustomTextField = {
        let view = CustomTextField()
        view.setupBorder()
        view.keyboardType = .emailAddress
        view.addSubview(emailErrorLabel)
        view.addTarget(self,
                       action: #selector(emailTextFieldChanging),
                       for: .editingChanged)
        view.autocapitalizationType = .none
        let attributedString = R.string.localization.attributedEmail()
        view.attributedPlaceholder = attributedString.placeholderText(fontSize: 16,
                                                                      fontColor: .galleryMain)
        view.setupTextFieldHeight(height: 40)
        
        return view
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let view = CustomTextField()
        view.setupBorder()
        view.addSubview(passwordErrorLabel)
        view.addTarget(self,
                       action: #selector(passwordTextFieldChanging),
                       for: .editingChanged)
        let attributedString = R.string.localization.attributedPassword()
        view.attributedPlaceholder = attributedString.placeholderText(fontSize: 16,
                                                                      fontColor: .galleryMain)
        view.textContentType = .oneTimeCode
        view.isSecureTextEntry = true
        view.addButton(button: eyeButton)
        view.setupTextFieldHeight(height: 40)
        
        return view
    }()
    
    lazy var confirmPasswordTextField: CustomTextField = {
        let view = CustomTextField()
        view.setupBorder()
        view.setupTextFieldHeight(height: 40)
        let attributedString = R.string.localization.attributedConfirmPassword()
        view.attributedPlaceholder = attributedString.placeholderText(fontSize: 16,
                                                                      fontColor: .galleryMain)
        view.textContentType = .oneTimeCode
        view.addSubview(confirmPasswordErrorLabel)
        view.addTarget(self, action: #selector(confirmPasswordTextFieldChanging), for: .editingChanged)
        view.isSecureTextEntry = true
        view.addButton(button: confirmEyeButton)
        
        return view
    }()
    
    lazy var eyeButton: UIButton = {
        let view = UIButton()
        view.setImage(R.image.passwordOff(), for: .normal)
        view.addTarget(self,
                       action: #selector(eyeButtonTapped),
                       for: .touchUpInside)
        
        return view
    }()
    
    lazy var confirmEyeButton: UIButton = {
        let view = UIButton()
        view.setImage(R.image.passwordOff(), for: .normal)
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
        view.setTitle(R.string.localization.signUpTitle(),
                      for: .normal)
        view.titleLabel?.font = R.font.robotoBold(size: 17)
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
        view.setTitle(R.string.localization.signInTitle(),
                      for: .normal)
        view.setTitleColor(.black,
                           for: .normal)
        view.titleLabel?.font = R.font.robotoBold(size: 17)
        view.backgroundColor = .white
        view.setupButtonHeight(height: 40)
        view.addTarget(self,
                       action: #selector(onSignInButtonTap),
                       for: .touchUpInside)
        
        return view
    }()
    
    lazy var leftBarButton: UIButton = {
        let view = UIButton.leftBarBut(title: R.string.localization.cancelTitle())
        view.addTarget(self,
                       action: #selector(popViewController),
                       for: .touchUpInside)
        
        return view
    }()
    
    lazy var emailErrorLabel: UILabel = {
        let view = UILabel()
        view.text = R.string.localization.invalidEmail()
        view.font = R.font.robotoRegular(size: 12)
        view.textColor = .galleryErrorRed
        view.isHidden = true
        
        return view
    }()
    
    lazy var userNameErrorLabel: UILabel = {
        let view = UILabel()
        view.text = R.string.localization.invalidUserName()
        view.font = R.font.robotoRegular(size: 12)
        view.textColor = .galleryErrorRed
        view.isHidden = true
        
        return view
    }()
    
    lazy var birthdayErrorLabel: UILabel = {
        let view = UILabel()
        view.text = R.string.localization.invalidBirthday()
        view.font = R.font.robotoRegular(size: 12)
        view.textColor = .galleryErrorRed
        view.isHidden = true
        return view
    }()
    
    lazy var passwordErrorLabel: UILabel = {
        let view = UILabel()
        view.text = R.string.localization.invalidPassword()
        view.font = R.font.robotoRegular(size: 12)
        view.textColor = .galleryErrorRed
        view.isHidden = true
        
        return view
    }()
    
    lazy var confirmPasswordErrorLabel: UILabel = {
        let view = UILabel()
        view.text = R.string.localization.passwordsDontMatch()
        view.font = R.font.robotoRegular(size: 12)
        view.textColor = .galleryErrorRed
        view.isHidden = true
        
        return view
    }()
    
    lazy var emailImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.email()
        
        return view
    }()
    
    lazy var userImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.user()

        return view
    }()
    
    lazy var birthdayImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.birthday()

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
        guard let emailText = emailTextField.text,
              let userText = userNameTextField.text,
              let birthdayText = birthdayTextField.text,
              let passwordText = passwordTextField.text,
              let confirmPasswordText = confirmPasswordTextField.text else {
                  return }
        
        if emailText.isEmpty || !emailText.isEmailValid {
            emailErrorLabel.isHidden = false
            emailTextField.layer.borderColor = .galleryErrorRed
            emailImageView.setupWarningImage()
        }
        
        if userText.isEmpty {
            userNameErrorLabel.isHidden = false
            userNameTextField.layer.borderColor = .galleryErrorRed
            userImageView.setupWarningImage()
        }
        
        if birthdayText.isEmpty {
            birthdayErrorLabel.isHidden = false
            birthdayTextField.layer.borderColor = .galleryErrorRed
            birthdayImageView.setupWarningImage()
        }
        
        if passwordText.isEmpty || !passwordText.isPasswordValid {
            passwordErrorLabel.isHidden = false
            passwordTextField.layer.borderColor = .galleryErrorRed
            eyeButton.setWarningImage()
        }
        
        if confirmPasswordText.isEmpty || !arePaswordsEqual() {
            confirmPasswordErrorLabel.isHidden = false
            confirmPasswordTextField.layer.borderColor = .galleryErrorRed
            confirmEyeButton.setWarningImage()
        }

        if emailText.isEmailValid && passwordText.isPasswordValid && arePaswordsEqual() && countOfFilledTextFields() == 5 {
            presenter?.registerNewUser(email: emailTextField.text ?? "",
                                       phone: "",
                                       fullName: userNameTextField.text ?? "",
                                       password: confirmPasswordTextField.text ?? "",
                                       username: userNameTextField.text ?? "",
                                       birthday: birthdayTextField.text ?? "",
                                       roles: [])
        } else {
            setAlertController(title: R.string.localization.invalidInput(),
                               message: R.string.localization.checkData())
        }
    }
    
    func countOfFilledTextFields() -> Int {
        guard let confirmText = confirmPasswordTextField.text,
              let passwordText = passwordTextField.text,
              let emailText = emailTextField.text,
              let userNameText = userNameTextField.text,
              let birthdayText = birthdayTextField.text else { return 0 }
        var count = 0
        let array = [confirmText, passwordText, emailText, userNameText, birthdayText]
        array.forEach { text in
            if !text.isEmpty {
                count += 1
            }
        }
       return count
    }
    
    @objc
    func eyeButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        changeEyeButtonImage(textField: passwordTextField, button: eyeButton)
    }
    
    @objc
    func confirmEyeButtonTapped() {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        changeEyeButtonImage(textField: confirmPasswordTextField, button: confirmEyeButton)
    }

    @objc
    func userNameTextFieldChanging() {
        userNameTextField.textFieldisChangingR(label: userNameErrorLabel,
                                               color: .galleryGrey,
                                               imageView: userImageView,
                                               image: R.image.user())
    }
    
    @objc
    func birthdayTextFieldChanging() {
        birthdayTextField.textFieldisChangingR(label: birthdayErrorLabel,
                                               color: .galleryGrey,
                                               imageView: birthdayImageView,
                                               image: R.image.birthday())
    }
    
    @objc
    func emailTextFieldChanging() {
        emailTextField.textFieldisChangingR(label: emailErrorLabel,
                                            color: .galleryGrey,
                                            imageView: emailImageView,
                                            image: R.image.email())
    }
    
    @objc
    func passwordTextFieldChanging() {
        passwordTextField.textFieldisChangingButton(label: passwordErrorLabel,
                                                    color: .galleryGrey)
        changeEyeButtonImage(textField: passwordTextField,
                             button: eyeButton)
    }
    
    @objc
    func confirmPasswordTextFieldChanging() {
        confirmPasswordTextField.textFieldisChangingButton(label: confirmPasswordErrorLabel,
                                                           color: .galleryGrey)
        changeEyeButtonImage(textField: confirmPasswordTextField,
                             button: confirmEyeButton)
    }
    
    @objc
    func passwordsMatching() {
        passwordTextField.textFieldisChangingButton(label: confirmPasswordErrorLabel,
                                                    color: .galleryGrey)
        changeEyeButtonImage(textField: confirmPasswordTextField,
                             button: confirmEyeButton)
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
        userNameTextField.addSubview(userImageView)
        birthdayTextField.addSubview(birthdayImageView)
        
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
        
        userImageView.snp.makeConstraints {
            $0.centerY.equalTo(userNameTextField.snp.centerY)
            $0.trailing.equalTo(userNameTextField.snp.trailing).inset(11)
        }
        
        birthdayImageView.snp.makeConstraints {
            $0.centerY.equalTo(birthdayTextField.snp.centerY)
            $0.trailing.equalTo(birthdayTextField.snp.trailing).inset(11)
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
        
        userNameErrorLabel.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.top.equalTo(userNameTextField.snp.bottom).offset(5)
            $0.height.equalTo(10)
        }
        
        birthdayErrorLabel.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.top.equalTo(birthdayTextField.snp.bottom).offset(5)
            $0.height.equalTo(10)
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
        
        confirmPasswordErrorLabel.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(5)
            $0.height.equalTo(10)
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
                $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(70)
            }
        }
    }
    
    func setupTextFieldsSpacing() {
        let array = [userNameTextField, birthdayTextField, emailTextField, passwordTextField, confirmPasswordTextField]
        array.forEach { textField in
            textFieldStackView.setCustomSpacing(20, after: textField)
        }
    }
    
    private func changeEyeButtonImage(textField: UITextField, button: UIButton) {
        if textField.isSecureTextEntry {
            button.setImage(R.image.passwordOff(), for: .normal)
        } else {
            button.setImage(R.image.password(), for: .normal)
        }
    }
    
    private func arePaswordsEqual() -> Bool {
        passwordTextField.text == confirmPasswordTextField.text
    }
    
}

extension SignUpViewController: SignUpViewProtocol {
    
    
}

