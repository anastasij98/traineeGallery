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
    
    func getImageFile(name: String) -> Observable<Data> {
        let url = URLConfiguration.url + URLConfiguration.media + name
        
        return RxAlamofire.data(.get, url)
    }

    func getImages(limit: Int,
                   pageToLoad: Int,
                   mode: SegmentMode) -> Observable<JSONModel>  {
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
        
        return RxAlamofire.data(.get, request, parameters: parametrs)
            .flatMap { data -> Observable<JSONModel> in
            do {
                let model = try JSONDecoder().decode(JSONModel.self, from: data)
                return .just(model)
            } catch let error {
                return .error(error)
            }
        }
    }
    
}
