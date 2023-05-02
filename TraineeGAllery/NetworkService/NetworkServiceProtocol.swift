//
//  NetworkService.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 07.04.23.
//

import Foundation
import RxSwift

protocol NetworkServiceProtocol {
    
    /// Загрузка картинок(JSON Мodel)
    /// - Parameters:
    ///   - limit: количество элементов в подгружаемой странице
    ///   - pageToLoad: подгружаемая страница
    ///   - mode: выбранный режим (new/popular)
    ///   - completion: обработка результата запроса
    /// - Returns: возвращаемый идектификатор запроса  (для отмены)
    func getImages(limit: Int,
                   pageToLoad: Int,
                   mode: SegmentMode) -> Observable<JSONModel>
//    func getImages(limit: Int,
//                   pageToLoad: Int,
//                   mode: SegmentMode) -> Single<JSONModel>
    
    /// Загрузка картинки на детальный экран
    /// - Parameters:
    ///   - name: имя картинки, взятое из модельки 
    ///   - completion: замыкание для обаботки результата
    /// - Returns: возвращаемый идектификатор запроса (для отмены)
    func getImageFile(name: String) -> Observable<Data>
    
    ///  Метод отмены запроса
    /// - Parameter id: идентификатор для отмены запросы
//    func cancelTask(withIdentifier id: String)
}
