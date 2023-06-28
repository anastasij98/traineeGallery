//
//  TextField.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.04.23.
//

import Foundation
import UIKit

extension UITextField {
    
    /// Преобразование String в NSMutableAttributedString для последующей установки в placeholder
    /// - Parameter text: текст, который необходимо преобразовать
    func atributedString(text: String) {
        let string = NSMutableAttributedString(string: text)
        string.addAttributes([.font : UIFont.robotoRegular(ofSize: 17),
                              .foregroundColor : UIColor.lightGray],
                             range: NSRange(location: 0, length: string.length))
        self.attributedPlaceholder = string
    }
    
    /// Настраивает границу поля textField: с borderColor = .galleryGrey , borderWidth = 1 и cornerRadius = 10
    func setupBorder() {
        self.layer.borderColor = .galleryGrey
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
    }
    
    /// Установка иконки с правой стороны textField'a
    /// - Parameter image: UIImage, которая будет установлена
    fileprivate func setupIcon(image: UIImage?) {
        guard let image = image else { return }
        let imageView = UIImageView(image: image)
        self.addSubview(imageView)

        imageView.snp.makeConstraints {
            $0.centerY.equalTo(self.snp.centerY)
            $0.trailing.equalTo(self.snp.trailing).inset(11)
        }
    }
    
    /// Установка иконки с правой стороны textField'a
    /// - Parameter image: UIImage, которая будет установлена
    func setupIconOnTextField(image: UIImage?) {
        guard let image = image,
              let imageView = self.subviews.first(where: {$0 is UIImageView}) as? UIImageView else {
            setupIcon(image: image)
            return }
        imageView.image = image
    }
    
    /// Добавление UIButton с правой стороны textField'a
    /// - Parameter button: UIButton, которая будет установленна
    func addButton(button: UIButton) {
        self.addSubview(button)
        
        button.snp.makeConstraints {
            $0.centerY.equalTo(self.snp.centerY)
            $0.trailing.equalTo(self.snp.trailing).inset(11)
        }
    }
    
    /// Установка высоты textField'a
    /// - Parameter height: величина высоты
    func setupTextFieldHeight(height: Int) {
        self.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
}
