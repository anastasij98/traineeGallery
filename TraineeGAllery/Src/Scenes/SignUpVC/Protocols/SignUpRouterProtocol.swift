//
//  SignUpRouterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol SignUpRouterProtocol {
    
    /// Получение и открытие экрана SignIn
    func openSignInViewController()
    
    /// Открытие TabBarController'a
    func openTabBarController()
    
    /// Закрытие экрана SignUp
    func popViewController(viewController: SignUpViewController)
}
