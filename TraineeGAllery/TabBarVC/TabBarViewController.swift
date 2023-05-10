//
//  TabBarViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit

protocol TabBarVCProtocol: AnyObject {
    
    
}

class TabBarViewController: UITabBarController {
    
    var presenter: TabBarPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = UINavigationController()
        let addPhotoVC = UINavigationController()
        let profileVC = UINavigationController()
        
//        let homeVC = MainConfigurator.getViewController()
//        let addPhotoVC = AddPhotoConfigurator.getViewController()
//        let profileVC = ProfileConfigurator.getViewController()

        self.setViewControllers([homeVC, addPhotoVC, profileVC], animated: true)
        
        MainConfigurator.open(navigationController: homeVC)
        AddPhotoConfigurator.openViewController(navigationController: addPhotoVC)
        ProfileConfigurator.openViewController(navigationController: profileVC)


        guard let items = tabBar.items else { return }
        let images = ["home", "photo", "profile"]

        for index in 0..<images.count {
            items[index].image = UIImage(named: images[index])
        }
        
    }
}

extension TabBarViewController: TabBarVCProtocol {
    
    
}
