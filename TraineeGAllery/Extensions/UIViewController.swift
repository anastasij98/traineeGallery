//
//  UIViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 18.05.23.
//

import Foundation
import UIKit
import TTGSnackbar
import PKHUD

extension UIViewController {
    
    private func setupNavigationBar(isHidden: Bool?,
                                    underlineColor: UIColor = .galleryGrey,
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
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.galleryBlue]
        appearance.backButtonAppearance = backButtonAppearance
        appearance.buttonAppearance = backButtonAppearance
        
        if let customBackButton = customBackButton {
            customBackButton.setTitleTextAttributes([.font : UIFont.robotoRegular(ofSize: 17),
                                                .foregroundColor : UIColor.galleryBlue],
                                               for: .normal)
            navigationItem.leftBarButtonItems = [customBackButton]
        } else {
            let backItem = UIBarButtonItem(title: backButtonTitle,
                                           style: .plain,
                                           target: nil,
                                           action: nil)
            backItem.setTitleTextAttributes([.font : UIFont.robotoRegular(ofSize: 17),
                                                .foregroundColor : UIColor.galleryBlue],
                                               for: .normal)
            let backButtonImage = UIImage(systemName: "chevron.left")
            appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
            navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
        }
        
        appearance.backgroundColor = .systemBackground
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .galleryBlue
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isOpaque = false
    }
    
    func setupNavigationBar(isHidden: Bool? = nil,
                            underlineColor: UIColor = .galleryGrey,
                            backButtonTitle: String = .init()) {
        setupNavigationBar(isHidden: isHidden,
                           underlineColor: underlineColor,
                           backButtonTitle: backButtonTitle,
                           customBackButton: nil)
    }
    
    func setupNavigationBar(isHidden: Bool? = nil,
                            underlineColor: UIColor = .galleryGrey,
                            customBackButton: UIBarButtonItem) {
        setupNavigationBar(isHidden: isHidden,
                           underlineColor: underlineColor,
                           backButtonTitle: nil,
                           customBackButton: customBackButton)
    }
}

protocol AlertMessageProtocol {
    
    func setAlertController(title: String, message: String)
    func alertControllerWithLeftButton(title: String, message: String, leftButtonTitle: String, leftButtonAction: @escaping (UIAlertAction) -> Void)
    func showSnackBar()
    func showProgressHUD()
    func showSuccessHUD(completion: @escaping (Bool) -> Void)
}

extension UIViewController: AlertMessageProtocol {
    
    func setAlertController(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        let button = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(button)
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertControllerWithLeftButton(title: String, message: String, leftButtonTitle: String, leftButtonAction: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        let leftButton = UIAlertAction(title: leftButtonTitle, style: UIAlertAction.Style.default, handler: leftButtonAction)
        let rigthButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(leftButton)
        alert.addAction(rigthButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    var snackBar: TTGSnackbar {
        let view = TTGSnackbar(message: "Photo uploaded successfully", duration: .middle)
        view.bottomMargin = (self.tabBarController?.tabBar.frame.size.height ?? 10) + 10
        view.leftMargin = 16
        view.rightMargin = 16
        view.cornerRadius = 10
        view.animationDuration = 5
        view.animationType = .fadeInFadeOut
        view.icon = UIImage(named: "Info")
        view.messageTextFont = .robotoRegular(ofSize: 18)
        view.backgroundColor = .galleryDarkGrey
        view.tintColor = .white
        
        return view
    }
    
    func showSnackBar() {
        snackBar.show()
    }

    func showProgressHUD() {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
    }
    
    func showSuccessHUD(completion: @escaping (Bool) -> Void) {
        PKHUD.sharedHUD.contentView = PKHUDSuccessView()
        PKHUD.sharedHUD.hide(afterDelay: 0.5, completion: completion)
    }
}
