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

    /// Количество картинок, загруженных пользователем
    func getItemsCount() -> Int
    
    /// Получение картинки пользователя для её отображения в collectionView(используется в cellForItemAt)
    func getItem(index: Int) -> ItemModel
    
    func didSelectObject(withIndex index: Int)
}
