//
//  UIImageView.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 22.06.23.
//

import Foundation
import UIKit
import SnapKit

extension UIImageView {
    
    ///  Установка картинки-предупреждеия(красный треугольник)
    func setupWarningImage() {
        self.image = R.image.warning()
    }
    
    /// Добавление подчеркивающей линии
    /// - Parameter color: цвет линии
    func addUnderLine(color: UIColor) {
        let titleUnderline = UIView()
        titleUnderline.backgroundColor = color
        self.addSubview(titleUnderline)
        
        titleUnderline.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalTo(self.snp.width)
            $0.bottom.equalTo(self.snp.bottom)
        }
    }
}
