//
//  UILabel.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation
import UIKit
import SnapKit

extension UILabel {
    
    /// Добавляет подчеркивающую линию
    func addUnderLine() {
        let titleUnderline = UIView()
        titleUnderline.backgroundColor = .galleryMain
        self.addSubview(titleUnderline)
        
        titleUnderline.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.width.equalTo(self.snp.width)
            $0.bottom.equalTo(self.snp.bottom).offset(5)
            $0.centerX.equalTo(self.snp.centerX)
        }
    }
}

