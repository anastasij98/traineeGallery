//
//  ProfileVCProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 28.06.23.
//

import Foundation

protocol ProfileVCProtocol: AnyObject {
    
    /// Установка view ViewControler'a
    /// - Parameters:
    ///   - userName: имя пользователя
    ///   - birthday: дата рождения пользователя
    func setupView(userName: String,
                   birthday: String)
    
    /// Обновление данных collectionView с картинками пользователя
    func updateCollectionView()
}
