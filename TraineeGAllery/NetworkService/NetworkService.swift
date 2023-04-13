//
//  NetworkService.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 07.04.23.
//

import Foundation
import Alamofire

class NetworkService {

//    var dataTasks: [String: URLSessionDataTask] = .init()
    var dataTasks: [String: DataRequest] = .init()

    func getImageFile(name: String,
                      completion: @escaping (Data) -> Void) -> String? {
//        guard let url = URL(string: URLConfiguration.url + URLConfiguration.media + name) else {
//            return nil
//        }
        let url = URLConfiguration.url + URLConfiguration.media + name
        
        let randomString = UUID().uuidString
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
//            if let data = data {
//                completion(data)
//            }
//            self?.dataTasks.removeValue(forKey: randomString)
//        }
//        task.resume()
//        dataTask = task
        
        let task = AF.request(url, method: .get).responseData { [weak self] response in
            if let data = response.data {
                completion(data)
            }
            self?.dataTasks.removeValue(forKey: randomString)
        }
        dataTasks[randomString] = task
        
        return randomString
    }
    
    func cancelTask(withIdentifier id: String) {
        dataTasks[id]?.cancel()
        dataTasks.removeValue(forKey: id)
    }
    
    deinit {
        dataTasks.forEach { $0.value.cancel() }
        dataTasks.removeAll()
    }
}

extension NetworkService: NetworkServiceProtocol {
    
    func getImages(limit: Int,
                   pageToLoad: Int,
                   mode: SegmentMode,
                   completion: @escaping ((Result<JSONModel, Error>) -> Void)) -> String? {
        let request = URLConfiguration.url + URLConfiguration.api
        var parametrs: Parameters = [
            "page": "\(pageToLoad)",
            "limit": "\(limit)"
        ]
        
        switch mode {
        case .new:
            parametrs["new"] = "true"
//            print(pageToLoad)
            
        case .popular:
            parametrs["popular"] = "true"
//            print(pageToLoad)
        }
        
        let randomString = UUID().uuidString

       let task = AF.request(request, method: .get, parameters: parametrs).responseData { [weak self] response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(JSONModel.self, from: data)
                    completion(.success(result))
                } catch let decodinError {
                    completion(.failure(decodinError))
                }
            } else if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.failure(NSError(domain: "Get nothing", code: 0)))
            }
           self?.dataTasks.removeValue(forKey: randomString)
        }
        dataTasks[randomString] = task
        
        return randomString
    }
}
