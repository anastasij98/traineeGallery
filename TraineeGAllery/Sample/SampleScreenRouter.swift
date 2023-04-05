//
//  SampleScreenRouter.swift
//  GalleryWithAPI
//
//  Created by Станислав Миненко on 04.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class SampleScreenRouter {
    
    weak var view: UIViewController?
    
    init(_ view: SampleScreenViewController) {
        self.view = view
    }
    
    func openSomeScene() {
        guard let navController = self.view?.navigationController else {
            return
        }
        //  SomeSceneConfigurator.open(navigationController: navController)
    }
}
