//
//  ApiUserGateway.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 29.06.23.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class ApiUserGateway: ApiBaseGateway, UserGateway {
    
    func getCurrentUser() -> Single<CurrentUserModel> {
        let request: ExtendedApiRequest<CurrentUserModel> = .getCurrentUser()
        
        return self.apiClient.execute(request: request)
    }

    func registerUser(entity: RequestRegisterModel) -> Single<ResponseRegisterModel> {
        let request: ExtendedApiRequest<ResponseRegisterModel> = .registerUser(entity)

        return self.apiClient.execute(request: request)
    }

    func deleteUser(id: Int) -> Single<Data> {
        let request: ExtendedApiRequest<Data> = .deleteUser(id)
        
        return self.apiClient.execute(request: request)
    }
    
    func authorizationRequest(userName: String, password: String) -> Single<AuthorizationModel> {
        let request: ExtendedApiRequest<AuthorizationModel> = .authorizationRequest(userName, password)
        
        return self.apiClient.execute(request: request)
    }
    
    func requestWithRefreshToken(refreshToken: String) -> Single<AuthorizationModel> {
        let request: ExtendedApiRequest<AuthorizationModel> = .requestWithRefreshToken(refreshToken)
        
        return self.apiClient.execute(request: request)
    }
    
    func changePassword(id: String,
                        oldPassword: String,
                        newPassword: String) -> Single<CurrentUserModel> {
        let request: ExtendedApiRequest<CurrentUserModel> = .changePassword(id,
                                                                            oldPassword,
                                                                            newPassword)
        
        return apiClient.execute(request: request)
    }
}
