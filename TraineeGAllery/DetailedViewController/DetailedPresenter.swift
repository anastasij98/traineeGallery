//
//  DetailedPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 05.04.23.
//

import Foundation

protocol DetailedPresenterProtocol {
    
    func downloadImg(data: Data)
    func viewDidLoad()
    func viewIsReady()
}

class DetailedPresenter {
    
    weak var view: DetailedViewControllerProtocol?
    var server: DetailedNetwork
    
    init(view: DetailedViewControllerProtocol? = nil, server: DetailedNetwork) {
        self.view = view
        self.server = server
    }
}

extension DetailedPresenter: DetailedPresenterProtocol {
    
    func downloadImg(data: Data) {
        view?.setImage(data: data)
    }
    
    func viewIsReady() {
        view?.setupView(name: server.viewdidload().name,
                        user: server.viewdidload().user,
                        description: server.viewdidload().description,
                        imageName: server.viewdidload().imageName,
                        date: server.getFormattedDateString(),
                        viewsCount: server.viewdidload().viewsCount)
    }
    
    func viewDidLoad() {
        viewIsReady()
        downloadImg(data: server.downloadImageFromInternet())
    }
}
