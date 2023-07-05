//
//  FileGateway.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 05.07.23.
//

import Foundation
import RxSwift

protocol FileGateway {
    
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
    
    ///  Запрос на создание медиа объекта
    /// - Parameters:
    ///   - file: объект в формате Data
    ///   - name: "file""
    /// - Returns: возвращается объект типа ImageModel
    func postMediaObject(file: Data,
                         name: String) -> Single<ImageModel>
    
    /// Запрос на создание фото с описанием
    /// - Parameters:
    ///   - name: имя картинки
    ///   - dateCreate: дата создания
    ///   - description: описание картиники
    ///   - new: тэг new
    ///   - popular: тэг popular
    ///   - iriId: iri путь к картинке
    /// - Returns: возвращается объект типа PostImageModel
    func postImageFile(name: String,
                       dateCreate: String,
                       description: String,
                       new: Bool,
                       popular: Bool,
                       iriId: Int) -> Single<ItemModel>
    
    /// Запрос на отображение загруженных картинок текущего пользователя
    /// - Parameter userId:Id пльзователя
    func getUsersImages(userId: Int) -> Single<ResponseModel>
}
