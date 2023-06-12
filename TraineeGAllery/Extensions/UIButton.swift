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
    
    static var leftBarButton: UIButton {
        
         let leftBarButton: UIButton

        if #available(iOS 15.0, *) {
             var configuration = UIButton.Configuration.plain()
             configuration.title = "Back"
             configuration.image = UIImage(systemName: "chevron.left")
             configuration.imagePlacement = .leading
             configuration.imagePadding = 5
             configuration.contentInsets = .init(top: 0, leading: -15, bottom: 0, trailing: 0)
             leftBarButton = UIButton(configuration: configuration, primaryAction: nil)
         } else {
             leftBarButton = UIButton(type: .system)
             leftBarButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
             leftBarButton.setTitle("Back", for: .normal)
             leftBarButton.sizeToFit()
             leftBarButton.imageEdgeInsets.left = -5
         }
     
         return leftBarButton
     }
    
   static func leftBarBut(title: String) -> UIButton {
        
         let leftBarButton: UIButton

        if #available(iOS 15.0, *) {
             var configuration = UIButton.Configuration.plain()
             configuration.title = title
             configuration.image = UIImage(systemName: "chevron.left")
             configuration.imagePlacement = .leading
             configuration.imagePadding = 5
             configuration.contentInsets = .init(top: 0, leading: -15, bottom: 0, trailing: 0)
             leftBarButton = UIButton(configuration: configuration, primaryAction: nil)
         } else {
             leftBarButton = UIButton(type: .system)
             leftBarButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
             leftBarButton.setTitle(title, for: .normal)
             leftBarButton.sizeToFit()
             leftBarButton.imageEdgeInsets.left = -5
         }
     
         return leftBarButton
     }

}
