//
//  TabBarViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit

protocol TabBarVCProtocol: AnyObject { }

class TabBarViewController: UITabBarController {
    
    var presenter: TabBarPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupTabImages()
    }
    
    func setupNavigation() {
        let mainVC = UINavigationController()
        let addPhotoVC = UINavigationController()
        let profileVC = UINavigationController()

        self.setViewControllers([mainVC, addPhotoVC, profileVC], animated: true)
        
        MainConfigurator.open(navigationController: mainVC)
        AddPhotoConfigurator.openViewController(navigationController: addPhotoVC)
        ProfileConfigurator.openViewController(navigationController: profileVC)
        tabBar.tintColor = .galleryMain
    }
    
    func setupTabImages() {
        guard let items = tabBar.items else { return }
        let images = ["main", "photo", "profile"]

        for index in 0..<images.count {
            items[index].image = UIImage(named: images[index])
        }
    }
}

extension TabBarViewController: TabBarVCProtocol { }
