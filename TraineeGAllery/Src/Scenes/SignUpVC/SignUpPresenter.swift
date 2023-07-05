//
//  SignInPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 25.04.23.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class SignUpPresenter {
    
    weak var view: SignUpViewProtocol?
    var router: SignUpRouterProtocol
    var userDefaultsService: UserDefaultsServiceProtocol
    
    var disposeBag = DisposeBag()
    
    private var userUseCase: UserUseCase
    
    init(view: SignUpViewProtocol? = nil,
         router: SignUpRouterProtocol,
         userDefaultsService: UserDefaultsServiceProtocol,
         userUseCase: UserUseCase) {
        self.view = view
        self.router = router
        self.userDefaultsService = userDefaultsService
        self.userUseCase = userUseCase
    }
    
    func registerNewUser(email: String,
                         phone: String,
                         fullName: String,
                         password: String,
                         username: String,
                         birthday: String,
                         roles: [String]) {
        
        let formattedBirthday = FormattedDateString.setFormattedDateString(string: birthday)
        let entity = RequestRegisterModel(email: email,
                                          phone: "\(Int.random(in: 1000..<9999))",
                                          fullName: fullName,
                                          password: password,
                                          username: username,
                                          birthday: formattedBirthday,
                                          roles: [""])
        self.userUseCase.registerUser(entity: entity)
            .observe (on: MainScheduler .instance)
            .subscribe (onCompleted: {
                self.router.openTabBarController()
            }, onError: { error in
                print(">>>>>>>>>ERROR \(String(describing: error))")
                self.view?.setAlertController(title: "Error", message: "\(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
    
    func countOfFilledTextFields(_ emailText: String,
                                 _ userText: String,
                                 _ birthdayText: String,
                                 _ passwordText: String,
                                 _ confirmPasswordText: String) -> Int {
        var count = 0
        let array = [confirmPasswordText, passwordText, emailText, userText, birthdayText]
        array.forEach { text in
            if !text.isEmpty {
                count += 1
            }
        }
        return count
    }
    
    func arePaswordsEqual(_ password: String,
                          _ confirmPassword: String) -> Bool {
        password == confirmPassword
    }
}

extension SignUpPresenter: SignUpPresenterProtocol {
    
    func onSignInButtonTap() {
        router.openSignInViewController()
    }
    
    func popViewController(viewController: SignUpViewController) {
        router.popViewController(viewController: viewController)
    }
    
    func onSignUpButtonTapped(emailText: String,
                              userText: String,
                              birthdayText: String,
                              passwordText: String,
                              confirmPasswordText: String) {
        
        if emailText.isEmpty || !emailText.isEmailValid {
            view?.showEmailError()
        }
        
        if userText.isEmpty {
            view?.showUserNameError()
        }
        
        if birthdayText.isEmpty {
            view?.showBirthdayError()
        }
        
        if passwordText.isEmpty || !passwordText.isPasswordValid {
            view?.passwordError()
        }
        
        if confirmPasswordText.isEmpty || !arePaswordsEqual(passwordText,
                                                            confirmPasswordText) {
            view?.confirmPasswordError(isPasswordValid: false)
        }
        
        if !confirmPasswordText.isPasswordValid {
            view?.confirmPasswordError(isPasswordValid: true)
        }
        
        if emailText.isEmailValid && passwordText.isPasswordValid && arePaswordsEqual(passwordText, confirmPasswordText) && countOfFilledTextFields(emailText, userText, birthdayText, passwordText, confirmPasswordText) == 5  {
            registerNewUser(email: emailText ,
                            phone: "",
                            fullName: userText,
                            password: confirmPasswordText,
                            username: userText,
                            birthday: birthdayText,
                            roles: [])
        } else {
            view?.showAlertControl()
        }
    }
}
