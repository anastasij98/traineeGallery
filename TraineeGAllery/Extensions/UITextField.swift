//
//  TextField.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.04.23.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    let padding = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 31)
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension UITextField {

    func setRightImage(imageName: String) {

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = UIImage(named: imageName)
        self.rightView = imageView
        self.rightViewMode = .always
    }
    
    func atributedString(text: String) {
        let string = NSMutableAttributedString(string: text)
        string.addAttributes([.font : UIFont.robotoRegular(ofSize: 17),
                              .foregroundColor : UIColor.lightGray],
                             range: NSRange(location: 0, length: string.length))
        self.attributedPlaceholder = string
    }
    
    func setupBorder() {
        self.layer.borderColor = .mainGrey
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
    }
    
    func setupIcon(name: String) {
        let imageView = UIImageView(image: UIImage(named: name))
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.centerY.equalTo(self.snp.centerY)
            $0.trailing.equalTo(self.snp.trailing).inset(11)
        }
    }
}
