//
//  ApiFileGateway.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 05.07.23.
//

import Foundation
import RxSwift

class ApiFileGateway: ApiBaseGateway, FileGateway {
    
    func getImages(limit: Int, pageToLoad: Int, mode: SegmentMode?, searchText: String?) -> Single<ResponseModel> {
        let request: ExtendedApiRequest<ResponseModel> = .getImages(limit, pageToLoad, mode, searchText)
        
        return self.apiClient.execute(request: request)
    }
    
    func getImageFile(name: String) -> Single<Data> {
        let request: ExtendedApiRequest<Data> = .getImageFile(name)
        
        return self.apiClient.execute(request: request)
    }
    
    func postMediaObject(file: Data, name: String) -> Single<ImageModel> {
        let request: ExtendedApiRequest<ImageModel> = .postMediaObject(file, name)
        
        return self.apiClient.execute(request: request)
    }
    
    func postImageFile(name: String, dateCreate: String, description: String, new: Bool, popular: Bool, iriId: Int) -> Single<ItemModel> {
        let request: ExtendedApiRequest<ItemModel> = .postImageFile(name, dateCreate, description, new, popular, iriId)
        
        return self.apiClient.execute(request: request)
    }
    
    func getUsersImages(userId: Int) -> Single<ResponseModel> {
        let request: ExtendedApiRequest<ResponseModel> = .getUsersImages(userId)
        
        return self.apiClient.execute(request: request)
    }
}
