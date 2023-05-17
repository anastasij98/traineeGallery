//
//  ColorExtension.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.03.23.
//

import Foundation
import UIKit

extension UIColor {
    
    static var customBlack: UIColor {
        #colorLiteral(red: 0.1516073942, green: 0.1516073942, blue: 0.1516073942, alpha: 1)
    }
    
    static var customDarkGrey: UIColor {
        #colorLiteral(red: 0.3725490196, green: 0.3725490196, blue: 0.3725490196, alpha: 1)
    }
    
    static var mainGrey: UIColor {
        #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
    }
    
    static var customPink: UIColor {
        #colorLiteral(red: 0.855356276, green: 0.3845037818, blue: 0.5663366914, alpha: 1)
    }

    static var customRed: UIColor {
        #colorLiteral(red: 0.9098039216, green: 0, blue: 0, alpha: 1)
    }
    
    static var customLightGrey: UIColor {
        #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
    }
}

extension UIColor {
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

extension CGColor {
    
    static var mainGrey: CGColor {
        #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
    }
}
