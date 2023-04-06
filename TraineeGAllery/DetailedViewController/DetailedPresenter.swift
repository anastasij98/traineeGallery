//
//  DetailedPresenter.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 05.04.23.
//

import Foundation

protocol DetailedPresenterProtocol {
    
    func getFormattedDateString() -> String
    func viewDidLoad()
}

class DetailedPresenter {
    
    weak var view: DetailedViewControllerProtocol?
    var model: ItemModel?
    var dataTask: URLSessionDataTask?

    
    init(view: DetailedViewControllerProtocol? = nil, model: ItemModel) {
        self.view = view
        self.model = model
    }
    
    func getFormattedDateString() -> String {
        guard let text = model?.date else {
            return "nil"
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: text) else {
            return ""
        }
        
        let neededDate = DateFormatter()
        neededDate.dateFormat = "dd.MM.yyyy"
        let dateString = neededDate.string(from: date)

        return dateString
    }

    deinit {
        dataTask?.cancel()
    }
}


extension DetailedPresenter: DetailedPresenterProtocol {
    
    func viewDidLoad() {
        let date = getFormattedDateString()

        view?.setupView(name: model?.name ?? "",
                        user: model?.user ?? "",
                        description: model?.description ?? "",
                        imageName: model?.image.name ?? "",
                        date: date,
                        viewsCount: "\(model?.id ?? 0)")
        downloadImage()
    }
    
    func downloadImage() {
        guard let name = model?.image.name,
              let url = URL(string: URLConfiguration.url + URLConfiguration.media + name) else {
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self?.view?.setImage(data: data)
                }
            }
        }
        task.resume()
        dataTask = task
    }
    
}
