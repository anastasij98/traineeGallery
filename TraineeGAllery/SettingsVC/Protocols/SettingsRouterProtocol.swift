//
//  RouterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 28.06.23.
//

import Foundation

protocol SettingsRouterProtocol {
    
    /// Закрытие экрана Settings
    /// - Parameter viewController: viewController, который надо закрыть
    func popViewController(viewController: SettingsViewController)
    
    /// Возвращение на приветственный экран
    func returnToWelcomeViewController()
}
