//
//  ProfileRouterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 28.06.23.
//

import Foundation

protocol ProfileRouterProtocol {
    
    /// Обращение к конфигуратору экрана настроек(Settings) для его открытия
    func openSettings()
    
    /// Открытие TabBarController'a
    /// - Parameter index: Parameter index: индекс выбранного экрана
    func openTabBarViewController(index: Int)
}
