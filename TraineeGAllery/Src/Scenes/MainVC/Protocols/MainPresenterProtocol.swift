//
//  MainPresenterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 17.05.23.
//

import Foundation

protocol MainPresenterProtocol {
    
    /// Текст, который вводится в searchBar'e
    var searchedText: String { get set }
    
    /// Режим SegmentedControll'a
    var mode: SegmentMode { get set }
    
    /// Выбор item'a соответствующего индекса из галереи
    /// - Parameter index: индекс item'a галереи
    func didSelectItem(withIndex index: Int)
    
    /// Подгрузка данных в галерею и её обновление в зависимоти от выбранного сегмента
    /// - Parameter index: индекс SegmentedControll'a
    func didSelectSegment(withIndex index: Int)
    
    /// Получение одного item'a из массива загруженных картинок
    /// - Parameter index: индекс item'a галереи
    /// - Returns: возвращет item типа ItemModel
    func getItem(index: Int) -> ItemModel
    
    /// Получение количетсва элементов из массива, в котором хранятся загруженные картинки
    func getItemsCount() -> Int

    /// Подгрузка новых данных(картинок) в зависимости от вводимого текста в SearchBar'e
    func loadMoreSearched(searchText: String)
    
    /// Обнуление страниц для осуществления запроса
    func resetValues()
    
    /// Очищение массива с картинками, которые ищутся в SearchBar'e
    func removeAllSearchedImages()

    /// Подгрузка новых данных(картинок) в основной массив для отображения в стартовой галерее
    func loadMore()
    
    /// Необходимость отображения footer'a внизу галереи
    func needIndicatorInFooter() -> Bool
    
    /// Начало отображение refreshControll'a
    func onRefreshStarted()
    
    /// Метод показывающий, что view готово к отображению
    func viewIsReady()
}
