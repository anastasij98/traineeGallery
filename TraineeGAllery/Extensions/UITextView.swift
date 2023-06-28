//
//  UITextView.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 16.05.23.
//

import Foundation
import UIKit

extension UITextView {
    
    /// Настраивает полe  textView: с borderColor = .galleryGrey , borderWidth = 1 и cornerRadius = 10
    /// - Parameter text: текст, который будет установлен в placeholder
    func setupTextView(text: String) {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = .galleryGrey
        self.textColor = .galleryGrey
        self.font = R.font.robotoRegular(size: 17)
        self.keyboardType = .default
        self.text = text
    }
}
