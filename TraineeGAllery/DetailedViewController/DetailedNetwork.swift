//
//  DetailedServer.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 07.04.23.
//

import Foundation
import Alamofire

protocol DetailedNetworkProtocol {
    
    func downloadImageFromInternet() -> Data
    func viewdidload() -> DetailedNetworkStruct
    func getFormattedDateString() -> String
}

struct DetailedNetworkStruct {
    
    let name: String
    let user: String
    let description: String
    let imageName: String
    let viewsCount: String
    let downloadDate: String
}

class DetailedNetwork {
    
    var presenter: DetailedPresenterProtocol?
    
    var dataTask: URLSessionDataTask?
    var model: ItemModel?
    
    init(presenter: DetailedPresenterProtocol? = nil, model: ItemModel) {
        self.presenter = presenter
        self.model = model
    }
    
    deinit {
        dataTask?.cancel()
    }
}

extension DetailedNetwork: DetailedNetworkProtocol {
    
    func downloadImageFromInternet() -> Data {
        guard let name = model?.image.name,
              let url = URL(string: URLConfiguration.url + URLConfiguration.media + name) else {
            return Data()
        }
        
        var dataData = Data()
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self?.presenter?.downloadImg(data: data)
                    dataData = data
                }
            }
        }
        task.resume()
        dataTask = task
        return dataData
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
    
    func viewdidload() -> DetailedNetworkStruct {
        let name = model?.name ?? ""
        let user = model?.user ?? ""
        let description = model?.description ?? ""
        let imageName = model?.image.name ?? ""
        let viewsCount = "\(model?.id ?? 0)"
        let downloadDate = getFormattedDateString()
        
        return DetailedNetworkStruct(name: name,
                                    user: user,
                                    description: description,
                                    imageName: imageName,
                                    viewsCount: viewsCount,
                                    downloadDate: downloadDate)
    }
}
