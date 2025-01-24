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
//        tabBar.addBorder(.top,
//                         color: .green,
//                         thickness: 20.0)
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

extension UITabBar {
    func addBorder(_ edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let subview = UIView()
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.backgroundColor = color
        self.addSubview(subview)
        switch edge {
        case .top, .bottom:
            subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
            subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
            subview.heightAnchor.constraint(equalToConstant: thickness).isActive = true
            if edge == .top {
                subview.topAnchor.constraint(equalTo: self.topAnchor, constant: -20).isActive = true
            } else {
                subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            }
        case .left, .right:
            subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            subview.widthAnchor.constraint(equalToConstant: thickness).isActive = true
            if edge == .left {
                subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
            } else {
                subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
            }
        default:
            break
        }
    }
}
