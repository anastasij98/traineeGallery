//
//  SampleScreenViewController.swift
//  GalleryWithAPI
//
//  Created by Станислав Миненко on 04.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class SampleScreenViewController: UIViewController {
    
    internal var presenter: SampleScreenPresenter?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewIsReady()
    }
}

extension SampleScreenViewController: SampleScreenView {
    
}
