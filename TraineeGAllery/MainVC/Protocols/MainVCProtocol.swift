//
//  MainVCProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol MainViewControllerProtocol: AnyObject, AlertMessageProtocol {
    
    /// В зависимоти от состояния сети показывается либо галерея, либо информация об отсутсвтии сети
    /// - Parameter isConnected: параметр, показывающий наличие/отсутсвие сети
    func connectionDidChange(isConnected: Bool)
    
    /// Скрывает refreshControll
    func hideRefreshControll()
    
    /// Обновление отображения галереи и устанавление последнего положения галереи, которое было открыто пользователем
    /// - Parameter restoreOffset: параметр, показывающий нужно ли устанавливать последнее положение или нет
    func updateView(restoreOffset: Bool)
}
