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

class SignUpViewController: UIViewController {
    
    var presenter: SignUpPresenterProtocol?
    
    lazy var textFieldsStackView: UIStackView = {
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
        view.layer.borderColor = .customGrey
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
        view.layer.borderColor = .customGrey
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        view.placeholder = "Birthday"
        view.keyboardType = .numbersAndPunctuation
        view.reloadInputViews()

        return view
    }()
    
    lazy var emailTextField: CustomTextField = {
        let view = CustomTextField()
        view.layer.borderColor = .customGrey
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
//      view.setRightImage(imageName: "email")

        return view
    }()

    lazy var oldPasswordTextField: CustomTextField = {
        let view = CustomTextField()
        view.layer.borderColor = .customGrey
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
        view.layer.borderColor = .customGrey
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
                       action: #selector(openGallery),
                       for: .touchUpInside)
        
        return view
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setupView()
    }
    
    func setupView() {
        view.addSubviews(signInTitle, textFieldsStackView, buttonsStackView)
        signInTitle.addSubview(titleUnderline)
        textFieldsStackView.addArrangedSubviews(userNameTextField, birthdayTextField, emailTextField, oldPasswordTextField, confirmPasswordTextField)
        textFieldsStackView.setCustomSpacing(29, after: userNameTextField)
        textFieldsStackView.setCustomSpacing(29, after: birthdayTextField)
        textFieldsStackView.setCustomSpacing(29, after: emailTextField)
        textFieldsStackView.setCustomSpacing(29, after: oldPasswordTextField)
        
        buttonsStackView.addArrangedSubviews(signUpButton, signInButton)
        buttonsStackView.setCustomSpacing(19, after: signUpButton)

        userNameTextField.addSubview(userImageView)
        birthdayTextField.addSubview(birthdayImageView)
        emailTextField.addSubview(emailImageView)
        oldPasswordTextField.addSubview(oldPasswordImageView)
        confirmPasswordTextField.addSubview(confirmPasswordImageView)

        signInTitle.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(188)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(30)
            $0.width.equalTo(105)
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
            $0.top.equalTo(textFieldsStackView.snp.bottom).offset(50)
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    @objc
    func openGallery() {
        presenter?.openGallery()
    }
}

extension SignUpViewController: SignUpViewProtocol {
    
    
}
