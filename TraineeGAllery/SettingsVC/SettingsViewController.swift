//
//  SettingsViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 08.05.23.
//

import Foundation
import UIKit
import SnapKit

protocol SettingsVCProtocol: AnyObject, AlertMessageProtocol {
    
    /// Установка данных пользователя в соответсвующие поля
    /// - Parameters:
    ///   - userName: имя пользователя
    ///   - birthday: дата рождения пользователя
    ///   - email: email пользователя
    func setupView(userName: String,
                   birthday: String,
                   email: String)
    
    /// Данные, которые нужно сохрнаить в usedrDefaults и передать на экран ProfileVC
    /// - Parameter completion: completion handler
    func textForSaving(completion: (_ userName: String, _ birthday: String, _ email: String)  -> Void)
    func deleteUser(action: UIAlertAction)
    func popViewController(action: UIAlertAction)
}

class SettingsViewController: UIViewController, UIScrollViewDelegate {
    
    var presenter: SettingsPresenterProtocol?
    
    var password = "password"
    
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
        view.alignment = .leading
        view.distribution = .fill
        
        return view
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        
        return view
    }()
    
    lazy var infoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fill
        
        return view
    }()
    
    lazy var personalDataLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .robotoRegular(ofSize: 14)
        view.text = "Personal data"
        
        return view
    }()
    
    lazy var userNameTextField: CustomTextField = {
        let view = CustomTextField()
        let text = "User Name"
        view.atributedString(text: text)
        view.setupBorder(color: .galleryGrey, borderWidth: 1, cornerRadius: 10)
        view.setupIcon(name: "user")
        
        return view
    }()
    
    lazy var birthdayTextField: CustomTextField = {
        let view = CustomTextField()
        let text = "Birthday"
        view.keyboardType = .numbersAndPunctuation
        view.atributedString(text: text)
        view.setupBorder(color: .galleryGrey, borderWidth: 1, cornerRadius: 10)
        view.setupIcon(name: "birthday")
        
        return view
    }()
    
    lazy var emailLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .robotoRegular(ofSize: 14)
        view.text = "E-mail adress"
        
        return view
    }()
    
    lazy var emailTextField: CustomTextField = {
        let view = CustomTextField()
        let text = "E-mail adress"
        view.atributedString(text: text)
        view.setupBorder(color: .galleryGrey, borderWidth: 1, cornerRadius: 10)
        view.setupIcon(name: "email")
        
        return view
    }()
    
    lazy var passwordLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .robotoRegular(ofSize: 14)
        view.text = password.capitalized
        
        return view
    }()
    
    lazy var oldPasswordTextField: CustomTextField = {
        let view = CustomTextField()
        let text = "Old \(password)"
        view.atributedString(text: text)
        view.setupBorder(color: .galleryGrey, borderWidth: 1, cornerRadius: 10)
        view.setupIcon(name: password)
        
        return view
    }()
    
    lazy var newPasswordTextField: CustomTextField = {
        let view = CustomTextField()
        let text = "New \(password)"
        view.atributedString(text: text)
        view.setupBorder(color: .galleryGrey, borderWidth: 1, cornerRadius: 10)
        view.setupIcon(name: password)
        
        return view
    }()
    
    lazy var confirmPasswordTextField: CustomTextField = {
        let view = CustomTextField()
        let text = "Confirm \(password)"
        view.atributedString(text: text)
        view.setupBorder(color: .galleryGrey, borderWidth: 1, cornerRadius: 10)
        view.setupIcon(name: password)
        
        return view
    }()
    
    lazy var deleteAccountButton: UIButton = {
        let view = UIButton()
        let text = "You can delete your account"
        let string = NSMutableAttributedString(string: text)
        string.addAttributes([.font : UIFont.robotoRegular(ofSize: 16),
                              .foregroundColor : UIColor.black],
                             range: NSRange(location: 0,
                                            length: 16))
        string.addAttributes([.font : UIFont.robotoRegular(ofSize: 16),
                              .foregroundColor : UIColor.galleryMain],
                             range: NSRange(location: 14,
                                            length: 13))
        view.setAttributedTitle(string, for: .normal)
        view.addTarget(self, action: #selector(onDeleteButtonTap), for: .touchUpInside)
        
        return view
    }()
    
    lazy var signOutButton: UIButton = {
        let view = UIButton()
        let text = "Sign Out"
        view.setupButtonTitle(view: view, text: text, color: .galleryMain, size: 16)
        view.addTarget(self, action: #selector(onSignOutButtonTap), for: .touchUpInside)
        
        return view
    }()
    
    lazy var leftBarButton: UIButton = {
        let view = UIButton.leftBarBut(title: "Cancel")
        view.addTarget(self,
                       action: #selector(onCancelButtonTap),
                       for: .touchUpInside)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        presenter?.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupRightNavBarButton()
        setupNavigationBar(isHidden: false, customBackButton: UIBarButtonItem(customView: leftBarButton))
    }
    
    func setupRightNavBarButton() {
        let rightButton = UIBarButtonItem(title: "Save",
                                          style: .plain,
                                          target: self,
                                          action: #selector(onSaveButtonTap))
        rightButton.setTitleTextAttributes([.font : UIFont.robotoBold(ofSize: 15),
                                            .foregroundColor : UIColor.galleryMain],
                                           for: .normal)
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(infoStackView, buttonsStackView)
        infoStackView.addArrangedSubviews(personalDataLabel,
                                          userNameTextField,
                                          birthdayTextField,
                                          emailLabel,
                                          emailTextField,
                                          passwordLabel,
                                          oldPasswordTextField,
                                          newPasswordTextField,
                                          confirmPasswordTextField)
        
        buttonsStackView.addArrangedSubviews(deleteAccountButton,
                                             signOutButton)
        
        setupSpacings()
        
        scrollView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(20)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
        }
        
        buttonsStackView.snp.makeConstraints {
            $0.centerX.equalTo(stackView.snp.centerX)
            
        }
        
        setupTextFields()
        
        setupLabelsAndButtons()
    }
    
    func setupSpacings() {
        stackView.setCustomSpacing(40, after: infoStackView)
        
        infoStackView.setCustomSpacing(14, after: personalDataLabel)
        infoStackView.setCustomSpacing(20, after: userNameTextField)
        infoStackView.setCustomSpacing(40, after: birthdayTextField)
        infoStackView.setCustomSpacing(14, after: emailLabel)
        infoStackView.setCustomSpacing(40, after: emailTextField)
        infoStackView.setCustomSpacing(14, after: passwordLabel)
        infoStackView.setCustomSpacing(20, after: oldPasswordTextField)
        infoStackView.setCustomSpacing(20, after: newPasswordTextField)
        
        buttonsStackView.setCustomSpacing(14, after: deleteAccountButton)
    }
    
    func setupTextFields() {
        let array = [userNameTextField, birthdayTextField, emailTextField, oldPasswordTextField, newPasswordTextField, confirmPasswordTextField]
        
        array.forEach { textField in
            textField.snp.makeConstraints {
                $0.height.equalTo(36)
                $0.leading.equalTo(stackView.snp.leading)
                $0.trailing.equalTo(stackView.snp.trailing)
            }
        }
    }
    
    func setupLabelsAndButtons() {
        let array = [personalDataLabel, emailLabel, passwordLabel, deleteAccountButton, signOutButton]
        array.forEach { view in
            view.snp.makeConstraints {
                $0.height.equalTo(22)
            }
        }
    }
    
    @objc
    func onCancelButtonTap() {
        presenter?.setCancelAlertController()
    }

    @objc
    func onDeleteButtonTap() {
        presenter?.setDeleteAlertController()
    }

    @objc
    func onSaveButtonTap() {
        guard let email = emailTextField.text,
              let userName = userNameTextField.text,
              let birthday = birthdayTextField.text else { return }
        presenter?.saveUsersChanges(email: email,
                                    phone: "45674321",
                                    username: userName,
                                    birthday: birthday)
    }
    
    @objc
    func onSignOutButtonTap() {
        if let viewWindow = view.window {
            presenter?.signOut()
        }
    }
}


extension SettingsViewController: SettingsVCProtocol {

    func setupView(userName: String,
                   birthday: String,
                   email: String) {
        userNameTextField.text = userName
        birthdayTextField.text = birthday
        emailTextField.text = email
    }

    func textForSaving(completion: (_ userName: String, _ birthday: String, _ email: String) -> Void) {
        guard let userName =  userNameTextField.text,
              let birthday = birthdayTextField.text,
              let email = emailTextField.text else { return }
        completion( userName, birthday, email)
    }
    
    func deleteUser(action: UIAlertAction) {
        presenter?.deleteUser()
    }
    
    func popViewController(action: UIAlertAction) {
        presenter?.popViewController(viewController: self)
    }
    
}
