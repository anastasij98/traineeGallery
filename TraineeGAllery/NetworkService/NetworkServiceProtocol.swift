//
//  NetworkService.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 07.04.23.
//

import Foundation
import RxSwift
import Alamofire

protocol NetworkServiceProtocol {
    
    /// Загрузка картинок(Response Мodel)
    /// - Parameters:
    ///   - limit: количество элементов в подгружаемой странице
    ///   - pageToLoad: подгружаемая страница
    ///   - mode: выбранный режим (new/popular)
    /// - Returns: возвращает Single типа ResponseModel
    func getImages(limit: Int,
                   pageToLoad: Int,
                   mode: SegmentMode) -> Single<ResponseModel>
    
    /// Загрузка картинки на детальный экран
    /// - Parameters:
    ///   - name: имя картинки, взятое из модельки 
    /// - Returns: возвращает Single типа Data
    func getImageFile(name: String) -> Single<Data>
}
