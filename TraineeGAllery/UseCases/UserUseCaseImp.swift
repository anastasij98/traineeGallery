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
    private let apiUserGateway: ApiUserGateway
    var userDefaultsService: UserDefaultsServiceProtocol
    var disposeBag = DisposeBag()
    
    init(_ userGateway: UserGateway,
         _ apiUserGateway: ApiUserGateway,
         _ userDefaultsService: UserDefaultsServiceProtocol) {
        
        self.userGateway = userGateway
        self.apiUserGateway = apiUserGateway
        self.userDefaultsService = userDefaultsService
    }
    
    func getCurrentUserinfo() -> Single<CurrentUserModel> {
        <#code#>
    }
    
    func registerUser(entity: RequestRegisterModel) -> Single<ResponseRegisterModel> {
        <#code#>
    }
    
    func deleteUser(id: Int) -> Single<Data> {
        <#code#>
    }
    
    func authorization(userName: String, password: String) -> Single<CurrentUserModel> {
        apiUserGateway.authorizationRequest(userName: userName, password: password)
            .observe(on: MainScheduler.instance)
            .debug()
            .flatMap({ [weak self] (authModel) -> Single<CurrentUserModel> in
                guard let self = self,
                      let accessToken = authModel.access_token,
                      let refreshToken = authModel.refresh_token else  {
                    return .error(NSError(domain: "", code: 0, userInfo: nil)) }
                self.userDefaultsService.saveTokens(accessToken: accessToken, refreshToken: refreshToken)
                
                return self.apiUserGateway.getCurrentUser()
            })
            .subscribe (onSuccess: { [weak self] currentUserModel in
                guard let self = self,
                      let fullName = currentUserModel.fullName,
                      let birthday = currentUserModel.birthday,
                      let email = currentUserModel.email,
                      let usersId = currentUserModel.id else { return }
                
                let formattedDate =  FormattedDateString.getFormattedDateString(string: birthday)
                self.userDefaultsService.saveUsersInfo(name: fullName,
                                                       birthday: formattedDate,
                                                       email: email)
                self.userDefaultsService.saveUsersId(id: usersId)
                print(currentUserModel)
            }, onFailure: { error in
                print(error)
            }, onDisposed: {
                //
            })
            .disposed(by: disposeBag)
    }
}
