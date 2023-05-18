//
//  UIViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 18.05.23.
//

import Foundation
import UIKit

extension UIViewController {
    
    private func setupNavigationBar(underlineColor: UIColor = .mainGrey,
                            backButtonTitle: String?,
                            customBackButton: UIBarButtonItem?,
                                    image: UIImage) {
        guard let appearance = navigationController?.navigationBar.standardAppearance else {
            return
        }
        
        appearance.configureWithDefaultBackground()
        appearance.shadowColor = underlineColor
        
        let backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.backButtonAppearance = backButtonAppearance
        appearance.buttonAppearance = backButtonAppearance
        
        if let customBackButton = customBackButton {
            customBackButton.setTitleTextAttributes([.font : UIFont.robotoRegular(ofSize: 15),
                                                .foregroundColor : UIColor.customDarkGrey],
                                               for: .normal)
            navigationController?.navigationBar.topItem?.leftBarButtonItems = [customBackButton]
        } else {
            let backItem = UIBarButtonItem(title: backButtonTitle,
                                           style: .plain,
                                           target: nil,
                                           action: nil)
            
            backItem.setTitleTextAttributes([.font : UIFont.robotoRegular(ofSize: 15),
                                                .foregroundColor : UIColor.customDarkGrey],
                                               for: .normal)
            
            navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
//            let backButtonImage = UIImage(named: "Vector")
//            let backButtonImage = UIColor.clear.image(CGSize(width: 0.1, height: 0.1))
            let backButtonImage = image
            appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        }
        
        appearance.backgroundColor = .systemBackground
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isOpaque = false
    }
    
    func setupNavigationBar(underlineColor: UIColor = .mainGrey,
                            backButtonTitle: String = .init(),
                            image: UIImage = .init()) {
        setupNavigationBar(underlineColor: underlineColor,
                           backButtonTitle: backButtonTitle,
                           customBackButton: nil,
                           image: image)
    }
    
    func setupNavigationBar(underlineColor: UIColor = .mainGrey,
                            customBackButton: UIBarButtonItem,
                            image: UIImage = .init()) {
        setupNavigationBar(underlineColor: underlineColor,
                           backButtonTitle: nil,
                           customBackButton: customBackButton,
                           image: image)
    }
}
