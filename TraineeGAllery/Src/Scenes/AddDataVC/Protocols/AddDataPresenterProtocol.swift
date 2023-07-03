//
//  AddDataPresenterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol AddDataPresenterProtocol {
    
    /// <#Description#>
    /// - Parameter viewController: <#viewController description#>
    func popViewController(viewController: AddDataViewController)
    
    /// <#Description#>
    /// - Returns: <#description#>
    func getCurrentDate() -> String
    
    /// <#Description#>
    /// - Parameters:
    ///   - name: <#name description#>
    ///   - file: <#file description#>
    ///   - dateCreate: <#dateCreate description#>
    ///   - description: <#description description#>
    ///   - new: <#new description#>
    ///   - popular: <#popular description#>
    ///   - viewController: <#viewController description#>
    func mediaObject(name: String,
                     file: Data,
                     dateCreate: String,
                     description: String,
                     new: Bool,
                     popular: Bool,
                     viewController: AddDataViewController)
}
