//
//  RegisterRouter.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 03.08.2023.
//

import Foundation

protocol RegisterRouter: AnyObject {
    func registerToken(device: String) -> ApiRoute
}

class RegisterRouterImpl: ApiRouter, RegisterRouter {
    var config: Config
    
    init(config: Config) {
        self.config = config
    }
    
    func registerToken(device: String) -> ApiRoute {
        var route = self.apiRoute
        route.apiComponents.url += "/api/register"
        route.apiComponents.method = .post
        route.apiComponents.data = ["device" : device]
        route.apiSessionType = .none
        return route
    }
}
