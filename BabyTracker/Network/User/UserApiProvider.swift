//
//  UserApiProvider.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 04.08.2023.
//

import Foundation
import Alamofire

protocol UserApiProvider: AnyObject {
    var apiSessionProvider: ApiSessionProvider { get }
    func getUser(completion: @escaping (UserModel?) -> Void)
    func updateUser(user: UserModel, completion: @escaping (UserModel?) -> Void)
}

class UserApiProviderImpl: ApiProvider, UserApiProvider {
    var userRouter: UserRouter
    
    init(userRouter: UserRouter,
         apiSessionProvider: ApiSessionProvider) {
        self.userRouter = userRouter
        super.init(apiSessionProvider: apiSessionProvider)
    }
    
    func getUser(completion: @escaping (UserModel?) -> Void) {
        let route = userRouter.getUser()
        let request = requestAF(route: route)
        request?.responseJSON { [weak self] response in
            do {
                let user: UserModel? = try self?.parseDataResponse(response: response)
                completion(user)
            } catch {
                #warning("Nice place to handle thrown errors")
            }
        }
    }
    
    func updateUser(user: UserModel, completion: @escaping (UserModel?) -> Void) {
        let route = userRouter.updateUser(userId: user.id, parameters: user)
        let request = requestAF(route: route)
        request?.responseJSON { [weak self] response in
            do {
                let user: UserModel? = try self?.parseDataResponse(response: response)
                completion(user)
            } catch {
                #warning("Nice place to handle thrown errors")
            }
        }
    }
}
