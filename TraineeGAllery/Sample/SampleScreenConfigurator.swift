//
//  SampleScreenConfigurator.swift
//  GalleryWithAPI
//
//  Created by Станислав Миненко on 04.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

enum SampleScreenConfigurator {
    
    static func configure(view: SampleScreenViewController) {
        let router = SampleScreenRouter(view)
        let presenter = SampleScreenPresenterImp(view, router)
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        let view = SampleScreenViewController()
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
