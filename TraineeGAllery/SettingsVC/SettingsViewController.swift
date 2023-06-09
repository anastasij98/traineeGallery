//
//  SettingsViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 08.05.23.
//

import Foundation
import UIKit
import SnapKit

protocol SettingsVCProtocol {
    
    /// <#Description#>
    /// - Parameters:
    ///   - userName: <#userName description#>
    ///   - birthday: <#birthday description#>
    ///   - email: <#email description#>
    func setupView(userName: String,
                   birthday: String,
                   email: String)
    /// <#Description#>
    /// - Parameter completion: <#completion description#>
    func textForSaving(completion: (_ userName: String, _ birthday: String, _ email: String)  -> Void)
}

class SettingsViewController: UIViewController, UIScrollViewDelegate {
    
    var presenter: SettingsPresenterProtocol?
    
    var password = "password"
    var alertCases = AlertCases.cancel
    
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
    
    lazy var imageStackView: UIStackView = {
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
    
    var userPhotoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.image = UIImage(named: "userCamera")
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.mainGrey.cgColor
        
        return view
    }()
    
    lazy var uploadPhotoButton: UIButton = {
        let view = UIButton()
        let text = "Upload photo"
        view.setupButtonTitle(view: view, text: text, color: .lightGray, size: 12)
        
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
        view.setupBorder()
        view.setupIcon(name: "user")
        
        return view
    }()
    
    lazy var birthdayTextField: CustomTextField = {
        let view = CustomTextField()
        let text = "Birthday"
        view.keyboardType = .numbersAndPunctuation
        view.atributedString(text: text)
        view.setupBorder()
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
        view.setupBorder()
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
        view.setupBorder()
        view.setupIcon(name: password)
        
        return view
    }()
    
    lazy var newPasswordTextField: CustomTextField = {
        let view = CustomTextField()
        let text = "New \(password)"
        view.atributedString(text: text)
        view.setupBorder()
        view.setupIcon(name: password)
        
        return view
    }()
    
    lazy var confirmPasswordTextField: CustomTextField = {
        let view = CustomTextField()
        let text = "Confirm \(password)"
        view.atributedString(text: text)
        view.setupBorder()
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
                              .foregroundColor : UIColor.customPink],
                             range: NSRange(location: 14,
                                            length: 13))
        view.setAttributedTitle(string, for: .normal)
        view.addTarget(self, action: #selector(onDeleteButtonTap), for: .touchUpInside)
        
        return view
    }()
    
    lazy var signOutButton: UIButton = {
        let view = UIButton()
        let text = "Sign Out"
        view.setupButtonTitle(view: view, text: text, color: .customPink, size: 16)
        view.addTarget(self, action: #selector(onSignOutButtonTap), for: .touchUpInside)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        presenter?.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewIsReady()
        setupRightNavBarButton()
        setupNavigationBar(customBackButton: UIBarButtonItem(title: "Cancel",
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(onCancelButtonTap)))
    }
    
    func setupRightNavBarButton() {
        let rightButton = UIBarButtonItem(title: "Save",
                                          style: .plain,
                                          target: self,
                                          action: #selector(onSaveButtonTap))
        rightButton.setTitleTextAttributes([.font : UIFont.robotoBold(ofSize: 15),
                                            .foregroundColor : UIColor.customPink],
                                           for: .normal)
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(imageStackView, infoStackView)
        imageStackView.addArrangedSubviews(userPhotoImageView,
                                           uploadPhotoButton)
        infoStackView.addArrangedSubviews(personalDataLabel,
                                          userNameTextField,
                                          birthdayTextField,
                                          emailLabel,
                                          emailTextField,
                                          passwordLabel,
                                          oldPasswordTextField,
                                          newPasswordTextField,
                                          confirmPasswordTextField,
                                          deleteAccountButton,
                                          signOutButton)
        
        setupSpacings()
        
        scrollView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
        }
        
        setupTextFields()
        
        userPhotoImageView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.width.equalTo(100)
            $0.centerX.equalTo(stackView.snp.centerX)
            $0.top.equalTo(stackView.snp.top).offset(21)
        }
        
        setupLabelsAndButtons()
    }
    
    func setupSpacings() {
        imageStackView.setCustomSpacing(10, after: userPhotoImageView)
        stackView.setCustomSpacing(20, after: imageStackView)
        infoStackView.setCustomSpacing(20, after: personalDataLabel)
        infoStackView.setCustomSpacing(29, after: userNameTextField)
        infoStackView.setCustomSpacing(39, after: birthdayTextField)
        infoStackView.setCustomSpacing(20, after: emailLabel)
        infoStackView.setCustomSpacing(39, after: emailTextField)
        infoStackView.setCustomSpacing(20, after: passwordLabel)
        infoStackView.setCustomSpacing(29, after: oldPasswordTextField)
        infoStackView.setCustomSpacing(29, after: newPasswordTextField)
        infoStackView.setCustomSpacing(39, after: confirmPasswordTextField)
        infoStackView.setCustomSpacing(20, after: deleteAccountButton)
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
        let array = [uploadPhotoButton, personalDataLabel, emailLabel, passwordLabel, deleteAccountButton, signOutButton]
        array.forEach { view in
            view.snp.makeConstraints {
                $0.height.equalTo(16)
            }
        }
    }
    
    func setAlertController(mode: AlertCases) {
        let alert = UIAlertController(title: "Confirmation",
                                      message: mode.rawValue,
                                      preferredStyle: UIAlertController.Style.alert)
        
        var leftButton = UIAlertAction()
        switch mode {
        case .delete:
            leftButton = UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: deleteUser)
        case .cancel:
            leftButton = UIAlertAction(title: "Exit", style: UIAlertAction.Style.default, handler: popViewController)
        }
        
        let rigthButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(leftButton)
        alert.addAction(rigthButton)
        alert.preferredAction = rigthButton
        self.present(alert, animated: true, completion: nil)
    }

    @objc
    func onCancelButtonTap() {
        setAlertController(mode: .cancel)
    }
    
    func popViewController(action: UIAlertAction) {
        presenter?.popViewController(viewController: self)
    }
    
    @objc
    func onDeleteButtonTap() {
        setAlertController(mode: .delete)
    }
    
    func deleteUser(action: UIAlertAction) {
        presenter?.deleteUser()
    }

    @objc
    func onSaveButtonTap() {
        presenter?.saveUsersChanges()
    }
    
    @objc
    func onSignOutButtonTap() {
        presenter?.signOut()
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
}
