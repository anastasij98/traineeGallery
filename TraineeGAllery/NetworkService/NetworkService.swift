//
//  NetworkService.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 07.04.23.

import Foundation
import RxSwift
import RxNetworkApiClient

class NetworkService {
    
    private let apiClient: ApiClient = ApiClientImp.defaultInstance(host: "https://gallery.prod1.webant.ru/")
    private let apiClientForOneImage: ApiClient = ApiClientImp.modifiedInstance(host: "https://gallery.prod1.webant.ru/")
    
}

extension NetworkService: NetworkServiceProtocol {
    
    func getImages(limit: Int,
                   pageToLoad: Int,
                   mode: SegmentMode?,
                   searchText: String?) -> Single<ResponseModel> {
        
        var searchedText = String()
        var switched: (String, String) = ("","")
        if let mode = mode {
            switch mode {
            case .new:
                switched = ("new", "true")
                if let searchText {
                    searchedText = searchText
                }
            case .popular:
                switched = ("popular", "true")
                if let searchText {
                    searchedText = searchText
                }
            }
        }
            let request: ApiRequest<ResponseModel> = .request(path: "api/photos/",
                                                              method: .get,
                                                              query: switched,
                                                              ("limit", "\(limit)"),
                                                              ("page", "\(pageToLoad)"),
                                                              ("name", searchedText))
            
            return apiClient.execute(request: request)
        }
        
        func getImageFile(name: String) -> Single<Data> {
            let request: ApiRequest<Data> = .request(path: "media/\(name)",
                                                     method: .get)
            
            return apiClientForOneImage.execute(request: request)
        }
    }
