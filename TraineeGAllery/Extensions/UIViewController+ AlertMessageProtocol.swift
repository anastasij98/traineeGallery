//
//  UIViewController+ AlertMessageProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 28.06.23.
//

import Foundation
import UIKit
import TTGSnackbar
import PKHUD

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
