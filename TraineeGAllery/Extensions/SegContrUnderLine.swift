//
//  SegmentedControlUnderLine.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 31.03.23.
//

import Foundation
import UIKit
import SnapKit

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
        let background = UIImage.getSegRect(color: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor, andSize: self.bounds.size)
        // segment background color and size
        self.setBackgroundImage(background, for: .normal, barMetrics: .default)
        self.setBackgroundImage(background, for: .selected, barMetrics: .default)
        self.setBackgroundImage(background, for: .highlighted, barMetrics: .default)
        
        let deviderLine = UIImage.getSegRect(color: UIColor.white.cgColor, andSize: CGSize(width: 1.0, height: 5))
        self.setDividerImage(deviderLine, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([.foregroundColor: UIColor.gray,
                                    .font: UIFont.systemFont(ofSize: 17, weight: .regular)], for: .normal)
        
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                     .font: UIFont.systemFont(ofSize: 17, weight: .regular)], for: .selected)
    }
    
    func highlightSelectedSegment(){
            removeBorder()
//            let lineWidth: CGFloat = self.bounds.size.width
            let lineWidth: CGFloat = self.bounds.width
            let lineHeight: CGFloat = 5.0

            let lineXPosition = CGFloat(selectedSegmentIndex * Int(lineWidth))
            let lineYPosition = self.bounds.size.height - 2.0
            let underlineFrame = CGRect(x: lineXPosition, y: lineYPosition, width: lineWidth + 5, height: lineHeight)
            let underLine = UIView(frame: underlineFrame)
            underLine.backgroundColor = UIColor(red: 0.812, green: 0.286, blue: 0.494, alpha: 1)
            underLine.tag = 1

            self.addSubview(underLine)
    
        }
    
    func underlinePosition(){
            guard let underLine = self.viewWithTag(1) else {return}
            let xPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
            UIView.animate(withDuration: 0.0, delay: 0.0, usingSpringWithDamping: 0.0, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                underLine.frame.origin.x = xPosition + 5
            })
        }
}
