//
//  ColorExtension.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.03.23.
//

import Foundation
import UIKit

extension UIColor {    
    static var customGrey: UIColor {
        #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
    }
}

extension CGColor {
    static var customGrey: CGColor {
        #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
    }
}


extension UIImage{
    class func getSegRect(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        context?.fill(rectangle)
        
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}

extension UISegmentedControl{
    func removeBorder(){
        let background = UIImage.getSegRect(color: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor, andSize: self.bounds.size) // segment background color and size
        self.setBackgroundImage(background, for: .normal, barMetrics: .default)
        self.setBackgroundImage(background, for: .selected, barMetrics: .default)
        self.setBackgroundImage(background, for: .highlighted, barMetrics: .default)
        
        let deviderLine = UIImage.getSegRect(color: UIColor.white.cgColor, andSize: CGSize(width: 1.0, height: 5))
        self.setDividerImage(deviderLine, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
//        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray,
//                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)
//                                    ], for: .normal)
        self.setTitleTextAttributes([.foregroundColor: UIColor.gray,
                                    .font: UIFont.systemFont(ofSize: 17, weight: .regular)], for: .normal)
        
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                     .font: UIFont.systemFont(ofSize: 17, weight: .regular)], for: .selected)
    }
}
