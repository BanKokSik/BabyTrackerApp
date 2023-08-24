//
//  UserRouter.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 04.08.2023.
//

import Foundation
import Alamofire

protocol UserRouter: AnyObject {
    func getUser() -> ApiRoute
    func updateUser(userId: String, parameters: UserModel) -> ApiRoute
}

class UserRouterImpl: ApiRouter, UserRouter {
    var config: Config
    
    init(config: Config) {
        self.config = config
    }
    
    func getUser() -> ApiRoute {
        var route = self.apiRoute
        route.apiComponents.url += "/api/user"
        route.apiSessionType = .header
        return route
    }
    
    func updateUser(userId: String, parameters: UserModel) -> ApiRoute {
        var route = self.apiRoute
        route.apiComponents.url += "/api/user/\(userId)"
        route.apiComponents.method = .put
        route.apiComponents.encoding = JSONEncoding.default
        route.apiComponents.data = parameters.asDictionary()
        route.apiSessionType = .header
        return route
    }
}
