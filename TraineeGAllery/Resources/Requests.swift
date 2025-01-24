//
//  Requests.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 29.06.23.
//

import Foundation
import RxSwift
import RxNetworkApiClient

extension ExtendedApiRequest {
    
    static func getImages(_ limit: Int,
                          _ pageToLoad: Int,
                          _ mode: SegmentMode?,
                          _ searchText: String?) -> ExtendedApiRequest {
        
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
        
        return extendedRequest(path: URLConfiguration.api,
                               method: .get,
                               query: switched,
                               ("limit", "\(limit)"),
                               ("page", "\(pageToLoad)"),
                               ("name", searchedText))
    }
    
    static func getImageFile(_ name: String) -> ExtendedApiRequest {
        extendedRequest(path: "media/\(name)",
                        method: .get)
    }
    
    static func authorizationRequest(_ userName: String, _ password: String) -> ExtendedApiRequest {
        extendedRequest(path: "oauth/v2/token",
                        method: .get,
                        query: ("client_id", URLConfiguration.clientId),
                        ("grant_type","password"),
                        ("username", userName),
                        ("password", password),
                        ("client_secret", URLConfiguration.clientSecret))
        
    }
    
    static func getCurrentUser() -> ExtendedApiRequest {
        extendedRequest(path: "api/users/current",
                        method: .get)
    }
    
    static func registerUser(_ entity: RequestRegisterModel) -> ExtendedApiRequest {
        extendedRequest(path: "api/users",
                               method: .post,
                               headers: [Header.contentJson],
                               body: entity)
    }
    
    static func deleteUser(_ id: Int) -> ExtendedApiRequest {
        extendedRequest(path: "api/users/\(id)",
                               method: .delete,
                               headers: [Header.contentJson])
    }
    
    static func postImageFile(_ name: String,
                              _ dateCreate: String,
                              _ description: String,
                              _ new: Bool,
                              _ popular: Bool,
                              _ iriId: Int) -> ExtendedApiRequest {
        let iri = "api/media_objects/\(iriId)"
        let imageModel = PostImageModel(name: name,
                                        description: description,
                                        date: dateCreate,
                                        new: new,
                                        popular: popular,
                                        image: iri)
        return extendedRequest(path: "api/photos",
                               method: .post,
                               headers: [Header.contentJson],
                               body: imageModel)
        
    }
    
    static func postMediaObject(_ file: Data,
                                _ name: String) -> ExtendedApiRequest {
        let uploadFile = UploadFile("file", file, "image")
        return extendedRequest(path: "api/media_objects",
                               method: .post,
                               files: [uploadFile])
    }
    
    static func getUsersImages(_ userId: Int) -> ExtendedApiRequest {
        extendedRequest(path: "api/photos",
                        method: .get,
                        query: ("user.id", "\(userId)"))
    }
    
    static func requestWithRefreshToken(_ refreshToken: String) -> ExtendedApiRequest  {
//    refresh: GET /oauth/v2/token?client_id=&grant_type=refresh_token&refresh_token=&client_secret=
        extendedRequest(path: "oauth/v2/token",
                        method: .get,
                        query: ("client_id", URLConfiguration.clientId),
                        ("grant_type", "refresh_token"),
                        ("refresh_token", refreshToken),
                        ("client_secret", URLConfiguration.clientSecret))
    }
    
    static func changePassword(_ id: String,
                               _ oldPassword: String,
                               _ newPassword: String) -> ExtendedApiRequest {
        
        extendedRequest(path: "api/users/update_password/\(id)",
                        method: .put,
                        headers: [.acceptJson],
                        query: ("oldPassword", oldPassword),
                        ("newPassword", newPassword))
    }
    
    static func updatePhoto(_ id: String,
                            _ name: String,
                            _ dateCreate: String,
                            _ description: String,
                            _ new: Bool,
                            _ popular: Bool,
                            _ iriId: Int) -> ExtendedApiRequest {
        //        /api/photos/{id}
        extendedRequest(path: "api/photos/\(id)",
                        method: .patch,
                        headers: [.acceptJson],
                        query: ("name", "oldPassword"),
                        ("dateCreate", "newPassword"),
                        ("description", "oldPassword"),
                        ("new", "newPassword"),
                        ("popular", "newPassword"),
                        ( "image", ""))
    }
}
