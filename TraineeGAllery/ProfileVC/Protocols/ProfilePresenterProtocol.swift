//
//  ProfilePresenterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 28.06.23.
//

import Foundation

protocol ProfilePresenterProtocol {
    
    /// Обращение к роутеру для открытия экрана настроек(Settings)
    func openSettings()
    
    /// Открытие TabBarController'a
    /// - Parameter index: индекс выбранного экрана
    func openTabBarViewController(index: Int)
    
    /// View готово к отображению
    func viewIsReady()

    /// <#Description#>
    /// - Returns: <#description#>
    func getItemsCount() -> Int
    
    /// <#Description#>
    /// - Parameter index: <#index description#>
    /// - Returns: <#description#>
    func getItem(index: Int) -> ItemModel
}
