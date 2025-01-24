//
//  SignInRouterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol SignInRouterProtocol {
    
    /// Получение и открытие экрана с TabBarController'ом
    func openTabBarController()
    
    /// Закрытие экрна SignIn
    func popViewController(viewController: SignInViewController)
}
