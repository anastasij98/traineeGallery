//
//  UserUseCaseImp.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 02.07.23.
//

import Foundation
import RxSwift

class UserUseCaseImp: UserUseCase {
    
    private let userGateway: UserGateway
    var userDefaultsService: UserDefaultsServiceProtocol
    
    init(_ userGateway: UserGateway,
         _ userDefaultsService: UserDefaultsServiceProtocol) {
        
        self.userGateway = userGateway
        self.userDefaultsService = userDefaultsService
    }
    
    func registerUser(entity: RequestRegisterModel) -> Completable {
        guard let username = entity.username,
              let password = entity.password else { return .empty()}
        return userGateway.registerUser(entity: entity)
            .flatMapCompletable { [weak self] registerModel in
                guard let self = self,
                      let usersId = registerModel.id else {
                    return .error(NSError(domain: "", code: 0, userInfo: nil))
                }
                self.userDefaultsService.saveUsersId(id: usersId)
                return Completable.empty()
            }
            .andThen(self.authorization(userName: username, password: password))
    }
    
    func authorization(userName: String, password: String) -> Completable {
        userGateway.authorizationRequest(userName: userName, password: password)
            .flatMapCompletable({ [weak self] authModel in
                guard let self = self,
                      let accessToken = authModel.access_token,
                      let refreshToken = authModel.refresh_token else  {
                    return .error(NSError(domain: "", code: 0, userInfo: nil)) }
                self.userDefaultsService.saveTokens(accessToken: accessToken, refreshToken: refreshToken)
                return Completable.empty()
            })
            .andThen(self.getCurrentUserinfo())
    }
    
    func getCurrentUserinfo() -> Completable {
        userGateway.getCurrentUser()
            .flatMapCompletable({ [weak self] userModel in
                guard let self = self,
                      let fullName = userModel.fullName,
                      let birthday = userModel.birthday,
                      let email = userModel.email,
                      let usersId = userModel.id else {
                    return .empty()
                }
                let formattedDate =  FormattedDateString.getFormattedDateString(string: birthday)
                self.userDefaultsService.saveUsersInfo(name: fullName,
                                                       birthday: formattedDate,
                                                       email: email)
                self.userDefaultsService.saveUsersId(id: usersId)
                return .empty()
            })
        
    }
    
    func deleteUser(id: Int) -> Completable {
        userGateway.deleteUser(id: id)
            .flatMapCompletable { data in
                self.userDefaultsService.removeTokensAndUsersInfo()
                return .empty()
            }
    }
    
    func requestWithRefreshToken(refreshToken: String) -> Single<AuthorizationModel> {
        userGateway.requestWithRefreshToken(refreshToken: refreshToken)
    }
    
    func changePassword(id: String,
                        oldPassword: String,
                        newPassword: String) -> Single<CurrentUserModel> {
        userGateway.changePassword(id: id,
                                   oldPassword: oldPassword,
                                   newPassword: newPassword)
    }
}
