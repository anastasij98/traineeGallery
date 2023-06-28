//
//  MainRouterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol MainRouterProtocol {
    
    /// Обращение к конфигуратору для открытия DetailedViewController'a
    /// - Parameter model: передаваемая модель типа ItemModel
    func openDetailedViewController(model: ItemModel)
}
