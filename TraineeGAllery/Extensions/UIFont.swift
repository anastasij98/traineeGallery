//
//  UIFont.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 06.04.23.
//

import Foundation
import UIKit

extension UIFont {
    
    class func robotoBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size) ?? .systemFont(ofSize: size)
    }

    class func robotoLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Light", size: size) ?? .systemFont(ofSize: size)
    }
    
    class func robotoRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: size) ?? .systemFont(ofSize: size)
    }
}
