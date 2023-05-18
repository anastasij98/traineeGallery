//
//  UIButton.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 18.05.23.
//

import Foundation
import UIKit

extension UIButton {
    
    func setupButtonTitle(view: UIButton, text: String, color: UIColor, size: CGFloat) {
        let string = NSMutableAttributedString(string: text)
        string.addAttributes([.font : UIFont.robotoRegular(ofSize: size),
                              .foregroundColor : color],
                             range: NSRange(location: 0, length: string.length))
        view.setAttributedTitle(string, for: .normal)
    }
}
