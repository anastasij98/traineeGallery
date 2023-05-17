//
//  AddPhotoPresenterProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 17.05.23.
//

import Foundation

protocol AddPhotoPresenterProtocol {
    
    /// Нажатие на кнопку NEXT и переход к  экрану AddDataViewController
    func onNextButtonTap()
    
    /// Открытие ImagePicker'a
    /// - Parameter viewController: viewController, который будет иметь связь с
    func openImagePicker(viewController: AddPhotoViewController)
    
    /// Получение данных из галереи устройства пользователя
    func fetchAssestFromLibrary()

    /// Получение количества элементов массива, в котором хранятся объекты из галереи устройства
    /// - Returns: количество элементов в массиве
    func getObjectsCount() -> Int

    /// Получение одного объекта из массива, в котором хранятся объекты из галереи устройства и приведение его к ImageObjectModel
    /// - Parameter index: индекс объектa
    /// - Returns: возвращет объект типа ImageObjectModel
    func getObject(withIndex index: Int) -> ImageObjectModel
    
    /// Выбранный объект в collectionView, показываемый в imageView АddPhotoViewController и передаваемый в AddDataViewController в виде Data
    /// - Parameter index: индекс выбранного объекта
    func didSelectObject(withIndex index: Int)
    
    /// Выбранный объект в imagePicker'e,показываемый в imageView АddPhotoViewController и передаваемый в AddDataViewController в виде Data
    /// - Parameter object: объект в виде Dat'ы
    func selectedObject(object: Data)
    
    func openTabBarViewController(index: Int)
}
