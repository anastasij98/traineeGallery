//
//  SignInPresenterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol SignInPresenterProtocol {
    
    /// Обращение к роутеру для открытия экрана с TabBarController'ом
    func openTabBar()
    
    /// Обращение к networkServic'y для отправки запроса на авторизацию
    func signInButtonTap(userName: String,
                         password: String)
    
    /// Обращение к роутеру для закрытия экрана SignIn
    /// - Parameter viewController: экран SignIn
    func popViewController(viewController: SignInViewController)
}
