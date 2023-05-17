//
//  MainPresenterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 17.05.23.
//

import Foundation

protocol MainPresenterProtocol {
    
    /// Режим SegmentedControll'a
    var mode: SegmentMode { get set }
    
    /// Выбор item'a соответствующего индекса в галереи
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
    /// - Returns: количество элементов в массиве
    func getItemsCount() -> Int
    
    /// Подгрузка новых данных(картинок)
    func loadMore()
    
    /// Необходимость отображения footer'a внизу галереи
    /// - Returns: true/false
    func needIndicatorInFooter() -> Bool
    
    /// Начало отображение refreshControll'a
    func onRefreshStarted()
    
    /// Метод показывающий, что view готово к отображению
    func viewIsReady()
}
