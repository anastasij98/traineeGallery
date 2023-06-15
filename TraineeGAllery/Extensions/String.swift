//
//  String.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 13.06.23.
//

import Foundation
import UIKit

extension String {
    
    /// Return Bool-value that shows is e-mail adress valid or not
    var isEmailValid: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Za-z0-9]{3,}+@[A-Za-z0-9]{2,}+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    /// Return Bool-value that shows is password valid or not
    var isPasswordValid: Bool {
            let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
            let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$"
            let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegx)
            return passwordCheck.evaluate(with: password)
    }
    
    ///Sets NSMutableAttributedString with specified fontSize and fontColor
    func placeholderText(fontSize size: CGFloat, fontColor color: UIColor) -> NSMutableAttributedString {
        let placeholderText = NSMutableAttributedString(string: self)
        placeholderText.addAttribute(.font,
                                    value: UIFont.robotoRegular(ofSize: size),
                                    range: NSRange(location: 0, length: placeholderText.length))
        placeholderText.addAttribute(NSAttributedString.Key.foregroundColor,
                                    value: color,
                                    range: NSRange(location: placeholderText.length - 1, length: 1))
        
        return placeholderText
        
    }
}
