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
    
    /// Загрузка картинок(JSON Мodel)
    /// - Parameters:
    ///   - limit: количество элементов в подгружаемой странице
    ///   - pageToLoad: подгружаемая страница
    ///   - mode: выбранный режим (new/popular)
    ///   - completion: обработка результата запроса
    /// - Returns: возвращаемый идектификатор запроса  (для отмены)
    func getImages(limit: Int,
                   pageToLoad: Int,
                   mode: SegmentMode) -> Single<JSONModel>
//    func getImages(limit: Int,
//                   pageToLoad: Int,
//                   mode: SegmentMode) -> Single<JSONModel>
    
    /// Загрузка картинки на детальный экран
    /// - Parameters:
    ///   - name: имя картинки, взятое из модельки 
    ///   - completion: замыкание для обаботки результата
    /// - Returns: возвращаемый идектификатор запроса (для отмены)
    func getImageFile(name: String) -> Single<Data>
}

/*
     Observable<Type> -> в onNext может сколько угодно раз вернуть объект Type
     Single<Type> -> в onSuccess может вернуть значение единожды
     Completable -> не имеет значений, в onCompleted оповещает об успехе
     
     ----------------------
     
     .do() -> наблюдаем за последовательностью
     .subscribe() -> подписываемся на последовательность
     .disposed(by: disposeBage) -> сохраняем последовательность в памяти
     
     */
