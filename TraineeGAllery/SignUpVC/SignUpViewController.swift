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
    
    lazy var signInTitle: UILabel = {
        let view = UILabel()
        view.text = "Sign Up"
        view.textAlignment = .center
        view.font = .robotoBold(ofSize: 30)
        
        return view
    }()
    
    lazy var titleUnderline: UIView = {
        let view = UIView()
        view.backgroundColor = .customPink
        
        return view
    }()
    
    lazy var userNameTextField: CustomTextField = {
        let view = CustomTextField()
        view.layer.borderColor = .mainGrey
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        let placeholderText = NSMutableAttributedString(string: "User Name*")
        placeholderText.addAttribute(.font,
                                    value: UIFont.robotoRegular(ofSize: 17),
                                    range: NSRange(location: 0, length: placeholderText.length))
        placeholderText.addAttribute(NSAttributedString.Key.foregroundColor,
                                    value: UIColor.customRed,
                                    range: NSRange(location: placeholderText.length - 1, length: 1))
        view.attributedPlaceholder = placeholderText
        
        return view
    }()
    
    lazy var birthdayTextField: CustomTextField = {
        let view = CustomTextField()
        view.layer.borderColor = .mainGrey
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        view.placeholder = "Birthday"
        view.keyboardType = .numbersAndPunctuation

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
        let placeholderText = NSMutableAttributedString(string: "Email*")
        placeholderText.addAttribute(.font,
                                    value: UIFont.robotoRegular(ofSize: 17),
                                    range: NSRange(location: 0, length: placeholderText.length))
        placeholderText.addAttribute(NSAttributedString.Key.foregroundColor,
                                    value: UIColor.customRed,
                                    range: NSRange(location: placeholderText.length - 1, length: 1))
        view.attributedPlaceholder = placeholderText
        view.keyboardType = .emailAddress

        return view
    }()

    lazy var oldPasswordTextField: CustomTextField = {
        let view = CustomTextField()
        view.layer.borderColor = .mainGrey
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        let placeholderText = NSMutableAttributedString(string: "Old password*")
        placeholderText.addAttribute(.font,
                                    value: UIFont.robotoRegular(ofSize: 17),
                                    range: NSRange(location: 0, length: placeholderText.length))
        placeholderText.addAttribute(NSAttributedString.Key.foregroundColor,
                                    value: UIColor.customRed,
                                    range: NSRange(location: placeholderText.length - 1, length: 1))
        view.attributedPlaceholder = placeholderText
        
        return view
    }()
    
    lazy var confirmPasswordTextField: CustomTextField = {
        let view = CustomTextField()
        view.layer.borderColor = .mainGrey
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        let placeholderText = NSMutableAttributedString(string: "Confirm password*")
        placeholderText.addAttribute(.font,
                                    value: UIFont.robotoRegular(ofSize: 17),
                                    range: NSRange(location: 0, length: placeholderText.length))
        placeholderText.addAttribute(NSAttributedString.Key.foregroundColor,
                                    value: UIColor.customRed,
                                    range: NSRange(location: placeholderText.length - 1, length: 1))
        view.attributedPlaceholder = placeholderText

        return view
    }()
    
    lazy var userImageView = UIImageView(image: UIImage(named: "user"))
    lazy var birthdayImageView = UIImageView(image: UIImage(named: "birthday"))
    lazy var emailImageView = UIImageView(image: UIImage(named: "email"))
    lazy var oldPasswordImageView = UIImageView(image: UIImage(named: "password"))
    lazy var confirmPasswordImageView = UIImageView(image: UIImage(named: "password"))
    
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
        view.backgroundColor = .customBlack
        view.layer.cornerRadius = 4
        view.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.width.equalTo(120)
        }
        
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
            $0.height.equalTo(18)
            $0.width.equalTo(103)
        }
        view.addTarget(self,
                       action: #selector(onSignInButtonTap),
                       for: .touchUpInside)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        checkOrientationAndSetLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(isHidden: false,
                           customBackButton: UIBarButtonItem(title: "Cancel",
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(popViewController)))
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
                $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(100)
            }
        }
    }
    
    func setupView() {
        view.backgroundColor = .white
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(signInTitle, textFieldStackView, buttonsStackView)
        stackView.setCustomSpacing(55, after: signInTitle)
        stackView.setCustomSpacing(50, after: textFieldStackView)

        signInTitle.addSubview(titleUnderline)
        
        textFieldStackView.addArrangedSubviews(userNameTextField, birthdayTextField, emailTextField, oldPasswordTextField, confirmPasswordTextField)

        setupTextFieldsSpacing()
        
        buttonsStackView.addArrangedSubviews(signUpButton, signInButton)
        buttonsStackView.setCustomSpacing(19, after: signUpButton)

        userNameTextField.addSubview(userImageView)
        birthdayTextField.addSubview(birthdayImageView)
        emailTextField.addSubview(emailImageView)
        oldPasswordTextField.addSubview(oldPasswordImageView)
        confirmPasswordTextField.addSubview(confirmPasswordImageView)

        scrollView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(100)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
        }

        titleUnderline.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.width.equalTo(signInTitle.snp.width)
            $0.bottom.equalTo(signInTitle.snp.bottom).offset(5)
            $0.centerX.equalTo(signInTitle.snp.centerX)
        }
        
        textFieldStackView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
        }
        
        userImageView.snp.makeConstraints {
            $0.centerY.equalTo(userNameTextField.snp.centerY)
            $0.trailing.equalTo(userNameTextField.snp.trailing).inset(11)
        }
        
        birthdayImageView.snp.makeConstraints {
            $0.centerY.equalTo(birthdayTextField.snp.centerY)
            $0.trailing.equalTo(birthdayTextField.snp.trailing).inset(11)
        }
        
        emailImageView.snp.makeConstraints {
            $0.centerY.equalTo(emailTextField.snp.centerY)
            $0.trailing.equalTo(emailTextField.snp.trailing).inset(11)
        }
        
        oldPasswordImageView.snp.makeConstraints {
            $0.centerY.equalTo(oldPasswordTextField.snp.centerY)
            $0.trailing.equalTo(oldPasswordTextField.snp.trailing).inset(11)
        }
        
        confirmPasswordImageView.snp.makeConstraints {
            $0.centerY.equalTo(confirmPasswordTextField.snp.centerY)
            $0.trailing.equalTo(confirmPasswordTextField.snp.trailing).inset(11)
        }
        
        buttonsStackView.snp.makeConstraints {
            $0.top.equalTo(textFieldStackView.snp.bottom).offset(50)
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    func setupTextFieldsSpacing() {
        let array = [userNameTextField, birthdayTextField, emailTextField, oldPasswordTextField, confirmPasswordTextField]
        array.forEach { textField in
            textFieldStackView.setCustomSpacing(29, after: textField)
        }
    }
    
    @objc
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func onSignInButtonTap() {
        presenter?.onSignInButtonTap()
    }
}

extension SignUpViewController: SignUpViewProtocol {
    
    
}
