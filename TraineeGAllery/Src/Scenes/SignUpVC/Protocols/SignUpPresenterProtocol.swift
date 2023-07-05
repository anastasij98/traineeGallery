//
//  SignUpPresenterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol SignUpPresenterProtocol {
    
    /// Обращение к роутеру для открытия экрана SigIn
    func onSignInButtonTap()
    
    /// Обращение к роутеру для закрытия экрана SignUp
    /// - Parameter viewController: экран SignUp
    func popViewController(viewController: SignUpViewController)
    
    /// При нажатии на конпку SignUp идет проверка на заполненность всех полей и их корректность. В случае успеха -> регистрация нового пользователя, в случае ошибки -> показ соответсвующего  уведомления
    func onSignUpButtonTapped(emailText: String,
                              userText: String,
                              birthdayText: String,
                              passwordText: String,
                              confirmPasswordText: String)
}
