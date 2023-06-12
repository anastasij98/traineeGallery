//
//  UITextView.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 16.05.23.
//

import Foundation
import UIKit

extension UITextView {
    
    func setupTextView(text: String) {
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = .mainGrey
        self.textColor = .galleryGrey
        self.font = .robotoRegular(ofSize: 17)
        self.keyboardType = .default
        self.text = text
    }
}
