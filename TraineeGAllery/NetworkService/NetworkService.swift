//
//  NetworkService.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 07.04.23.

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

class NetworkService {
    
}

extension NetworkService: NetworkServiceProtocol {
    
    func getImages(limit: Int,
                   pageToLoad: Int,
                   mode: SegmentMode) -> Single<JSONModel> {
        let request = URLConfiguration.url + URLConfiguration.api
        var parametrs: Parameters = [
            "page": "\(pageToLoad)",
            "limit": "\(limit)"
        ]
        
        switch mode {
        case .new:
            parametrs["new"] = "true"
            
        case .popular:
            parametrs["popular"] = "true"
        }
//           return RxAlamofire.data(.get, request, parameters: parametrs)
        return RxAlamofire.request(.get, request, parameters: parametrs)
                    .validate(statusCode: 200..<300)
                    .responseData()
                    .asSingle()
                    .flatMap { response, data -> Single<JSONModel> in
                        print("Status code: \(response.statusCode)")
                        do {
                            let model = try JSONDecoder().decode(JSONModel.self, from: data)
                            return .just(model)
                        } catch let error {
                            return .error(error)
                        }
                    }
    }
    
    func getImageFile(name: String) -> Single<Data> {
        let url = URLConfiguration.url + URLConfiguration.media + name
        
        return RxAlamofire.data(.get, url)
            .asSingle()
    }
}


