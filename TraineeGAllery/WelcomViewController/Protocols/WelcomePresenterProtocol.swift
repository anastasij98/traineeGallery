//
//  WelcomePresenterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol WelcomePresenterProtocol {
    
    /// Открытие экрана SignUp для регистрации пользователя
    func onSignUpButtonTap()
    
    /// Открытие экрана SignIn для авторизации пользователя
    func onSignInButtonTap()
}
