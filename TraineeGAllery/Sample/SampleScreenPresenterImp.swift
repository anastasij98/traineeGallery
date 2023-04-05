//
//  SampleScreenPresenterImp.swift
//  GalleryWithAPI
//
//  Created by Станислав Миненко on 04.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation

class SampleScreenPresenterImp: SampleScreenPresenter {
    
    private weak var view: SampleScreenView?
    private let router: SampleScreenRouter
    
    init(_ view: SampleScreenView,
         _ router: SampleScreenRouter) {
        self.view = view
        self.router = router
    }
    
    func viewIsReady() {
        
    }
}
