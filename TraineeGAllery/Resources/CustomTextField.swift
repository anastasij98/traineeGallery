//
//  CustomTextField.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 28.06.23.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }
    
    let padding = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 40)
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    open override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        if !isSecureTextEntry { return true  }
        
        if let currentText = text { insertText(currentText) }
        
        return true
    }
    
    /// Метод, редактирующий отображение выбранного textField'а. Скрывает передаваемый label, меняет borderColor, передает новую картинку для отображения в imageView
    /// - Parameters:
    ///   - label: label, который будет скрыт
    ///   - color: цвет, который будет установлен в borderColor
    ///   - imageView: выбранный imageView
    ///   - image: картинка, которую надо передать в  imageView.image для её установки
    func textFieldIsChanging(label: UILabel, color: CGColor) {
        label.isHidden = true
        self.layer.borderColor = color
    }
    
    /// Метод, редактирующий отображение выбранного textField'а. Скрывает передаваемый label, меняет borderColor
    /// - Parameters:
    ///   - label: label, который будет скрыт
    ///   - color: цвет, который будет установлен в borderColor
//    func textFieldIsChangingButton(label: UILabel, color: CGColor) {
//        label.isHidden = true
//        self.layer.borderColor = color
//    }
}

