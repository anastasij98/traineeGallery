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
    ///   - limit: количество элементов вна запрашиваемой странице
    ///   - pageToLoad: запрашиваемая страница
    ///   - mode: выбранный режим (New/Popular)
    ///   - searchText: введённый текст в поле SearchBar'a
    /// - Returns: возвращает Single, содержащий один объект типа ResponseModel
    func getImages(limit: Int,
                         pageToLoad: Int,
                         mode: SegmentMode?,
                         searchText: String?) -> Single<ResponseModel>
    
    /// Загрузка картинки на детальный экран
    /// - Parameters:
    ///   - name: имя картинки, взятое из модельки 
    /// - Returns: возвращает Single, содержащий один объект типа Data
    func getImageFile(name: String) -> Single<Data>
}

