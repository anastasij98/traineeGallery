//
//  SignInRouter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 26.04.23.
//

import Foundation
import UIKit

protocol SignInRouterProtocol {
    
    func openGallery()
}

class SignInRouter {
    
    weak var view: UIViewController?
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension SignInRouter: SignInRouterProtocol {
    
    func openGallery() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = windowScenes?.windows.first
        window?.rootViewController = TabBarConfigurator.getViewController()
    }
}
