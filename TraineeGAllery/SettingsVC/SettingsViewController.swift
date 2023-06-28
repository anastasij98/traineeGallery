//
//  SettingsViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 08.05.23.
//

import Foundation
import UIKit
import SnapKit

class SettingsViewController: UIViewController, UIScrollViewDelegate {
    
    var presenter: SettingsPresenterProtocol?
    
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
        view.font = R.font.robotoRegular(size: 14)
        view.text = R.string.localization.settingsPersonalData()
        
        return view
    }()
    
    lazy var userNameTextField: CustomTextField = {
        let view = CustomTextField()
        let text = R.string.localization.settingsUserName()
        view.atributedString(text: text)
        view.setupBorder()
        view.setupIcon(image: R.image.user())
        return view
    }()
    
    lazy var birthdayTextField: CustomTextField = {
        let view = CustomTextField()
        let text = R.string.localization.settingsBirthday()
        view.atributedString(text: text)
        view.keyboardType = .numbersAndPunctuation
        view.setupBorder()
        view.setupIcon(image: R.image.birthday())

        return view
    }()
    
    lazy var emailLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = R.font.robotoRegular(size: 14)
        view.text = R.string.localization.settingsEmailAdress()
        
        return view
    }()
    
    lazy var emailTextField: CustomTextField = {
        let view = CustomTextField()
        let text = R.string.localization.settingsEmailAdress()
        view.atributedString(text: text)
        view.setupBorder()
        view.setupIcon(image: R.image.email())
        
        return view
    }()
    
    lazy var passwordLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = R.font.robotoRegular(size: 14)
        view.text = R.string.localization.password().capitalized
        
        return view
    }()
    
    lazy var oldPasswordTextField: CustomTextField = {
        let view = CustomTextField()
        let text = R.string.localization.oldPasswordTitle()
        view.atributedString(text: text)
        view.setupBorder()
        view.addButton(button: oldEyeButton)
        view.isSecureTextEntry = true

        return view
    }()
    
    lazy var newPasswordTextField: CustomTextField = {
        let view = CustomTextField()
        let text = R.string.localization.newPasswordTitle()
        view.atributedString(text: text)
        view.setupBorder()
        view.addButton(button: eyeButton)
        view.isSecureTextEntry = true

        return view
    }()
    
    lazy var confirmPasswordTextField: CustomTextField = {
        let view = CustomTextField()
        let text = R.string.localization.confirmPasswordTitle()
        view.atributedString(text: text)
        view.setupBorder()
        view.addButton(button: confirmEyeButton)
        view.isSecureTextEntry = true

        return view
    }()
    
    lazy var deleteAccountButton: UIButton = {
        let view = UIButton()
        let text = R.string.localization.deleteAccountButtonTitle()
        let string = NSMutableAttributedString(string: text)
        string.addAttributes([.font : R.font.robotoRegular(size: 16),
                              .foregroundColor : UIColor.black],
                             range: NSRange(location: 0,
                                            length: 16))
        string.addAttributes([.font : R.font.robotoRegular(size: 16),
                              .foregroundColor : UIColor.galleryMain],
                             range: NSRange(location: 14,
                                            length: 13))
        view.setAttributedTitle(string, for: .normal)
        view.addTarget(self, action: #selector(onDeleteButtonTap), for: .touchUpInside)
        
        return view
    }()
    
    lazy var signOutButton: UIButton = {
        let view = UIButton()
        let text = R.string.localization.signOutButtonTitle()
        view.setupButtonTitle(view: view,
                              text: text,
                              color: .galleryMain,
                              size: 16)
        view.addTarget(self,
                       action: #selector(onSignOutButtonTap),
                       for: .touchUpInside)
        
        return view
    }()
    
    lazy var leftBarButton: UIButton = {
        let view = UIButton.leftBarBut(title: R.string.localization.cancelButtonTitle())
        view.addTarget(self,
                       action: #selector(onCancelButtonTap),
                       for: .touchUpInside)
        
        return view
    }()
    
    lazy var oldEyeButton: UIButton = {
        let view = UIButton()
        view.setImage(R.image.passwordOff(), for: .normal)
        view.addTarget(self,
                       action: #selector(oldEyeButtonTapped),
                       for: .touchUpInside)
        
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
    
    @objc
    func oldEyeButtonTapped() {
        oldPasswordTextField.isSecureTextEntry.toggle()
        changeEyeButtonImage(textField: oldPasswordTextField, button: oldEyeButton)
    }
    
    @objc
    func eyeButtonTapped() {
        newPasswordTextField.isSecureTextEntry.toggle()
        changeEyeButtonImage(textField: newPasswordTextField, button: eyeButton)
    }
    
    @objc
    func confirmEyeButtonTapped() {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        changeEyeButtonImage(textField: confirmPasswordTextField, button: confirmEyeButton)
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
        presenter?.saveUsersChanges()
    }
    
    @objc
    func onSignOutButtonTap() {
        if let _ = view.window {
            presenter?.signOut()
        }
    }
    
    private func changeEyeButtonImage(textField: UITextField, button: UIButton) {
        if textField.isSecureTextEntry {
            button.setImage(R.image.passwordOff(), for: .normal)
        } else {
            button.setImage(R.image.password(), for: .normal)
        }
    }
    
    func setupRightNavBarButton() {
        let rightButton = UIBarButtonItem(title: R.string.localization.saveButtonTitle(),
                                          style: .plain,
                                          target: self,
                                          action: #selector(onSaveButtonTap))
        rightButton.setTitleTextAttributes([.font : R.font.robotoBold(size: 15),
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
