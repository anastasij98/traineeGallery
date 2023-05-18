//
//  UIViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 18.05.23.
//

import Foundation
import UIKit

extension UIViewController {
    
    private func setupNavigationBar(isHidden: Bool?,
                                    underlineColor: UIColor = .mainGrey,
                                    backButtonTitle: String?,
                                    customBackButton: UIBarButtonItem?) {
        if let isHidden = isHidden {
            navigationController?.setNavigationBarHidden(isHidden,
                                                         animated: true)
            if isHidden {
                return
            }
        }
        
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
            navigationItem.leftBarButtonItems = [customBackButton]
        } else {
            let backItem = UIBarButtonItem(title: backButtonTitle,
                                           style: .plain,
                                           target: nil,
                                           action: nil)
            
            backItem.setTitleTextAttributes([.font : UIFont.robotoRegular(ofSize: 15),
                                                .foregroundColor : UIColor.customDarkGrey],
                                               for: .normal)
            
            navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
            let backButtonImage = R.image.vector()
                appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        }
        
        appearance.backgroundColor = .systemBackground
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isOpaque = false
    }
    
    func setupNavigationBar(isHidden: Bool? = nil,
                            underlineColor: UIColor = .mainGrey,
                            backButtonTitle: String = .init()) {
        setupNavigationBar(isHidden: isHidden,
                           underlineColor: underlineColor,
                           backButtonTitle: backButtonTitle,
                           customBackButton: nil)
    }
    
    func setupNavigationBar(isHidden: Bool? = nil,
                            underlineColor: UIColor = .mainGrey,
                            customBackButton: UIBarButtonItem) {
        setupNavigationBar(isHidden: isHidden,
                           underlineColor: underlineColor,
                           backButtonTitle: nil,
                           customBackButton: customBackButton)
    }
}
