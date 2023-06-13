//
//  ColorExtension.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.03.23.
//

import Foundation
import UIKit

extension UIColor {
    
    static var galleryBlack: UIColor {
        #colorLiteral(red: 0.1516073942, green: 0.1516073942, blue: 0.1516073942, alpha: 1)
    }
    
    static var galleryGrey: UIColor {
        #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
    }
    
    static var galleryLightGrey: UIColor {
        #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.937254902, alpha: 1)
    }
    
    
    static var galleryMain: UIColor {
        #colorLiteral(red: 0.8117647059, green: 0.2862745098, blue: 0.4941176471, alpha: 1)
    }

    static var galleryErrorRed: UIColor {
        #colorLiteral(red: 0.9098039216, green: 0, blue: 0, alpha: 1)
    }
    
    static var galleryBlue: UIColor {
        #colorLiteral(red: 0.3040042818, green: 0.6906013489, blue: 1, alpha: 1)
        
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
    
    static var galleryErrorRed: CGColor {
        #colorLiteral(red: 0.9098039216, green: 0, blue: 0, alpha: 1)
    }
}
