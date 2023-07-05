//
//  FileUseCase.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 05.07.23.
//

import Foundation
import RxSwift

protocol FileUseCase {
    
    var isLoading: Bool { get set }
    var hasMorePages: Bool { get }
    var pageToLoad: Int { get set }
    var currentPage: Int { get set }
    var currentCountOfPages: Int { get set }
    
    /// Загрузка картинок(Response Мodel)
    /// - Parameters:
    ///   - limit: количество элементов вна запрашиваемой странице
    ///   - pageToLoad: запрашиваемая страница
    ///   - mode: выбранный режим (New/Popular)
    ///   - searchText: введённый текст в поле SearchBar'a
    /// - Returns: возвращает Single, содержащий один объект типа ResponseModel
    func getImages(limit: Int,
                   mode: SegmentMode?,
                   searchText: String?) -> Single<ResponseModel>
    
    /// Загрузка картинки на детальный экран
    /// - Parameters:
    ///   - name: имя картинки, взятое из модельки
    /// - Returns: возвращает Single, содержащий один объект типа Data
    func getImageFile(name: String) -> Single<Data>
    
    ///  Запрос на создание медиа объекта и на создание фото с описанием
    /// - Parameters:
    ///   - file: объект в формате Data
    ///   - name: "file""
    ///   - imageName: имя картинки
    ///   - dateCreate: дата создания
    ///   - description: описание картиники
    ///   - new: тэг new
    ///   - popular: тэг popular
    ///   - iriId: iri путь к картинке
    /// - Returns: возвращается объект типа ImageModel
    func postMediaObject(file: Data, name: String, dateCreate: String, description: String, new: Bool, popular: Bool) -> Single<ItemModel>
    
    /// Запрос на отображение загруженных картинок текущего пользователя
    /// - Parameter userId:Id пльзователя
    func getUsersImages(userId: Int) -> Single<ResponseModel>
}
